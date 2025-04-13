# CassandraRealTime
This is a Cassandra project that will use features in the DB to collect real time data for a dashboard of sorts

# Team 5 - Phase 2

## System: Cassandra
This project demonstrates a query Cassandra handles better than MySQL.

### Query Purpose
Fetch all earthquakes in a specific location sorted by time.

### Why It’s a Strength of Cassandra
- No need for indexes or joins
- Automatically partitioned by location, sorted by time
- Scales efficiently with large datasets

### Cassandra Version
Apache Cassandra 4.x


### How to Run
How to download Cassandra on Window 11
In order to download the cassandra, we use a dockor to be able to run cassandra. So we used this website in order to download cassandra. 
https://www.docker.com/products/docker-desktop/

I also used this video to be able to indicate. I did everything correctly. 
https://www.youtube.com/watch?v=ZyBBv1JmnWQ&ab_channel=CodeBear

Once you created um Cassandra, then you have to created an account and downloaded a Cassandra extension.
Then you're gonna have to run these commands. 
        docker images    
 to see if there is images in the docker
        docker pull cassandra 
        docker images  
can see if you pull cassandra as an image then go to the docker then run the image of cassandra
docker exec -it <Image id>cqlsh
change <Image id> to the image id in docker then you be in cassandra.
Copy all of the information from create.cql that how to run cassandra.



### References
- USGS API: https://earthquake.usgs.gov/fdsnws/event/1/
- Baeldung Cassandra Cheatsheet: https://www.baeldung.com/cassandra-query-cheat-sheet
- Tutorials: YouTube links in assignment
