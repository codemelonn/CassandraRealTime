const fetch = (...args) => import('node-fetch').then(({ default: fetch }) => fetch(...args));
const cassandra = require('./cassandra');

/* 
    - This function connects to the USGS earthquake API
    - pulls recent data and gives us back a list of individual earthquake events
*/

let totalEarthquakes = []; 

async function fetchEarthquakes() {
   
    for (let year = 2010; year <= 2023; year++) {
        for (let month = 1; month <= 12; month++) {
            const start = `${year}-${month.toString().padStart(2, '0')}-01`;
            const end = `${year}-${month.toString().padStart(2, '0')}-28`; // safe for all months

            const url = `https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=${start}&endtime=${end}`;
            try {
                const response = await fetch(url);
                console.log(`📡 ${start} - Status: ${response.status}`);
                const data = await response.json();

                if (Array.isArray(data.features)) {
                    totalEarthquakes.push(...data.features);
                }
            } catch (error) {
                console.log(`❌ Error in parsing through ${start}: ${error.message}`);
            }
        }
    }

    return totalEarthquakes;
}


async function insertEarthquakeData(eq) {

    // tested this batch size, this is the highest number we can use before it wont accept the batch size
    const BATCH_SIZE = 275; 
    const totalBatches = Math.ceil(eq.length / BATCH_SIZE); 
    let count = 0; 

    const query = `
    INSERT INTO earthquake_by_day (
      date_occurred, time_occurred, id, magnitude, depth,
      region, country, latitude, longitude
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    for (let i = 0; i < totalBatches; i++) {

        const batch = eq.slice(i * BATCH_SIZE, (i + 1) * BATCH_SIZE); 
        const queries = []; 

        for (const feature of batch) {
            try {

                const time = new Date(feature.properties.time);
                const date = time.toISOString().split('T')[0];        
                const id = feature.id; 
                const magnitude = feature.properties.mag; 
                const depth = feature.geometry.coordinates[2]; 
                const region = feature.properties.place?.split(',')[0] || 'Unknown';
                const country = feature.properties.place?.split(', ').pop() || 'Unknown';
                const latitude = feature.geometry.coordinates[1];
                const longitude = feature.geometry.coordinates[0];
    
                queries.push({
                    query, 
                    params: [
                        date,
                        time,
                        id,
                        magnitude,
                        depth,
                        region,
                        country,
                        latitude,
                        longitude
                    ]
                }); 

                count++; 
            } catch (err) {
                console.error(`❌ Skipped ${feature.id}: ${err.message}`);
            }
        } // end of for loop 

        try {
            await cassandra.batch(queries, { prepare: true });
            console.log(`📦 Batch ${i + 1}/${totalBatches} inserted (${count} total records so far)`);  
        } catch (err) {
            console.error(`❌ Failed to insert batch ${i + 1}: ${err.message}`);
        }

    } // end of try catch 

    console.log(`✅ Done! Inserted total ${count} records.`); 
}

async function main() {
    await fetchEarthquakes(); 
    await insertEarthquakeData(totalEarthquakes); 
}

main();
