#!/bin/bash

echo "🔄 Starting Cassandra via Docker Compose..."
echo " " 
docker-compose up -d

echo "⏳ Waiting for Cassandra to initialize (about 30s)..."
echo " " 
sleep 10

echo "🧱 Creating schema from create.cql..."
echo " " 
docker exec -i cassandra cqlsh < cql/create_tables.cql

echo "✅ Setup complete. You can now use 'docker exec -it cassandra cqlsh' to interact with Cassandra."
echo " " 
