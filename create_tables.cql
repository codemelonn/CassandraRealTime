CREATE KEYSPACE IF NOT EXISTS EarthquakeData
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1}; 

-- this table will be a partition for storing earthquake data per the day it happens
-- we will cluster this by the time it occurred in descending order

CREATE TABLE earthquake_by_day (

    date_occurred       DATE, 
    time_occurred       TIMESTAMP, 
    id                  UUID, 
    magnitude           FLOAT, 
    intensity           FLOAT, 
    depth               FLOAT, 
    region              TEXT, 
    latitude            FLOAT, 
    longitude           FLOAT, 

    PRIMARY KEY ((date_occurred), time_occurred, id)
) WITH CLUSTERING ORDER BY (time_occurred DESC); 