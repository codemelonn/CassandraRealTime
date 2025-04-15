#!/bin/bash

echo "🔄 Starting Cassandra via Docker Compose..."
docker-compose up -d

echo "⏳ Waiting for Cassandra to initialize (about 30s)..."
sleep 10

echo "🧱 Creating schema from create.cql..."
docker exec -i cassandra cqlsh < cassandra/create_tables.cql

echo "🧪 Inserting test data from testqueries.cql..."
#docker exec -i cassandra cqlsh < cassandra/testqueries.cql

echo "✅ Setup complete. You can now use 'docker exec -it cassandra cqlsh' to interact with Cassandra."
