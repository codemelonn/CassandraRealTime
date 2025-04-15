const fetch = (...args) => import('node-fetch').then(({ default: fetch }) => fetch(...args));
const cassandra = require('./cassandra');

/* 
    - This function connects to the USGS earthquake API
    - pulls recent data and gives us back a list of individual earthquake events
*/

let totalEarthquakes = []; 

async function fetchEarthquakes() {
   
    for (let year = 2023; year <= 2024; year++) {
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

    const query = `
    INSERT INTO earthquake_by_day (
      date_occurred, time_occurred, id, magnitude, depth,
      region, country, latitude, longitude
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    for (const feature of eq) {
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

            await cassandra.execute(query, [
                date,
                time,
                id,
                magnitude,
                depth,
                region,
                country,
                latitude,
                longitude
            ], { prepare: true });

            console.log(`✅ Inserted earthquake ${id}`);
            console.log(`Inserted ${totalEarthquakes.length}!`);
        } catch (err) {
            console.error(`❌ Failed to insert ${feature.id}: ${err.message}`);
        }
    }

}

async function main() {
    await fetchEarthquakes(); 
    await insertEarthquakeData(totalEarthquakes); 
}

main();
