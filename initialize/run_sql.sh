echo "Running your MySQL queries!" 
echo " " 
sleep 2

docker exec -i mysql mysql -u root -ppassword < sql/testQueries.sql