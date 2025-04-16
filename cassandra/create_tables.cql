CREATE KEYSPACE IF NOT EXISTS earthquakedata
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1}; 

USE earthquakedata; 

-- this table will be a partition for storing earthquake data per the day it happens
-- we will cluster this by the time it occurred in descending order

-- since cassandra is non relational we don't need to normalize the data,
-- and reuse tables like in sql

CREATE TABLE earthquake_by_day (

    date_occurred       DATE, 
    time_occurred       TIMESTAMP, 
    id                  TEXT, 
    magnitude           FLOAT,  
    depth               FLOAT, 
    country             TEXT,
    region              TEXT, 
    latitude            FLOAT, 
    longitude           FLOAT, 

    PRIMARY KEY ((date_occurred), time_occurred, id)
) WITH CLUSTERING ORDER BY (time_occurred DESC); 