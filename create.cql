CREATE KEYSPACE IF NOT EXISTS earthquakes_demo 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1}; \

USE earthquakes_demo; 

CREATE TABLE IF NOT EXISTS earthquake_info (
    id UUID PRIMARY KEY, 
    location TEXT, 
    magnitude FLOAT
); 

INSERT INTO earthquake_info (id, location, magnitude)
VALUES (uuid(), 'New Mexico', 5.1); 