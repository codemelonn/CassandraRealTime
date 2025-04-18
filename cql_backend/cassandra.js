// reusable cassandra client connection 

const cassandra = require('cassandra-driver');

const client = new cassandra.Client({
  contactPoints: ['localhost'],  
  localDataCenter: 'datacenter1',
  keyspace: 'earthquakedata',
});


module.exports = client;
