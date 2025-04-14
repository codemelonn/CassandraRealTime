#!/bin/bash

echo "🔄 Starting Cassandra via Docker Compose..."
docker-compose up -d

echo "⏳ Waiting for Cassandra to initialize (about 30s)..."
sleep 30

echo "🧱 Creating schema from create.cql..."
docker exec -i cassandra cqlsh < create.cql

echo "🧪 Inserting test data from testqueries.cql..."
docker exec -i cassandra cqlsh < testqueries.cql

echo "✅ Setup complete. You can now use 'docker exec -it cassandra cqlsh' to interact with Cassandra."
