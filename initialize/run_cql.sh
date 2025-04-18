echo "Running your Cassandra queries!" 
echo " " 
sleep 2

docker exec -i cassandra cqlsh < cql/testqueries.cql