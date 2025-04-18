#!/bin/bash

echo "🔄 Starting Cassandra and MySQL via Docker Compose..."
echo " " 
docker-compose up -d

echo "⏳ Waiting for Cassandra to initialize (about 10s)..."
echo " " 
sleep 5

echo "🧱 Creating schema from create.cql and create.sql..."
echo " " 
docker exec -i cassandra cqlsh < cql/create_tables.cql
docker exec -i mysql mysql -u root -ppassword < sql/create.sql


echo "✅ Setup complete. You can now use 'docker exec -it cassandra cqlsh' to interact with Cassandra."
echo " " 
