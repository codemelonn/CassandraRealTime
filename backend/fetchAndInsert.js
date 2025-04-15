const fetch = (...args) => import('node-fetch').then(({ default: fetch }) => fetch(...args));
const client = require('./cassandra');

async function fetchEarthquakes() {
  const url = 'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&minmagnitude=5&limit=10';
  const response = await fetch(url);
  const data = await response.json();
  return data.features;
}

function extractCountry(place) {
  if (!place) return null;
  const parts = place.split(',');
  return parts.length > 1 ? parts[parts.length - 1].trim() : null;
}

async function insertEarthquake(eq) {
  const props = eq.properties;
  const coords = eq.geometry.coordinates;
  const id = eq.id;
  const date = new Date(props.time);

  const query = `
    INSERT INTO earthquake_by_day (
      date_occurred, time_occurred, id, magnitude, depth,
      region, country, latitude, longitude
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  const params = [
    date.toISOString().split('T')[0], // date_occurred (YYYY-MM-DD)
    date,                              // time_occurred (timestamp)
    id,
    props.mag,
    coords[2],                         // depth
    props.place,
    extractCountry(props.place),
    coords[1],                         // lat
    coords[0],                         // lon
  ];

  await client.execute(query, params, { prepare: true });
}

async function main() {
  const earthquakes = await fetchEarthquakes();

  for (const eq of earthquakes) {
    try {
      await insertEarthquake(eq);
      console.log(`✅ Inserted earthquake ${eq.id}`);
    } catch (err) {
      console.error(`❌ Failed to insert ${eq.id}:`, err.message);
    }
  }

  await client.shutdown();
}

main();
