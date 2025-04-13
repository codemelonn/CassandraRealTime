CREATE KEYSPACE IF NOT EXISTS earthquakes_demo 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1}; 

USE earthquakes_demo; 
CREATE TABLE IF NOT EXISTS earth_info (
    id UUID PRIMARY KEY,
    event_time TIMESTAMP,
    location TEXT,
    magnitude FLOAT
);

-- Infrastructure Damage Table
CREATE TABLE IF NOT EXISTS earthquake_damage (
    earthquake_id UUID,
    damage_id TIMEUUID,
    damage_type TEXT,
    estimated_cost DECIMAL,
    PRIMARY KEY (earthquake_id, damage_id)
) WITH CLUSTERING ORDER BY (damage_id DESC);

-- Person Damage Table
CREATE TABLE IF NOT EXISTS person_damage (
    earthquake_id UUID,
    person_id TIMEUUID,
    name TEXT,
    injury_type TEXT,
    status TEXT,
    PRIMARY KEY (earthquake_id, person_id)
) WITH CLUSTERING ORDER BY (person_id DESC);

CREATE TABLE IF NOT EXISTS earthquake_by_location (
    location TEXT,
    event_time TIMESTAMP,
    id UUID,
    magnitude FLOAT,
    PRIMARY KEY (location, event_time)
) WITH CLUSTERING ORDER BY (event_time DESC);



INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES (def664be-d66f-4769-8d09-b6387d1b5581, '2011-02-03 04:05+0000', 'New Mexico', 5.1); 

INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES (uuid(), '2025-02-24 04:05+0000', 'San Francisco', 5.8)
USING TTL 604800;

INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES (uuid(), '2025-01-30 04:05+0000', 'Los Angeles', 4.7);

INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES (ba275b5c-8ddf-4499-b1b8-594f6757053a, toTimestamp(now()), 'Los Angeles', 3.9);

INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES (0623ca47-47db-4c97-8ce6-b67b8163ac15, toTimestamp(now()), 'San Francisco', 5.2);


-- Insert Damage Data
INSERT INTO earthquake_damage (earthquake_id, damage_id, damage_type, estimated_cost)
VALUES (ba275b5c-8ddf-4499-b1b8-594f6757053a, now(), 'Collapsed buildings', 5000000.00);

INSERT INTO earthquake_damage (earthquake_id, damage_id, damage_type, estimated_cost)
VALUES (ba275b5c-8ddf-4499-b1b8-594f6757053a, now(), 'Damaged roads', 1200000.00);

-- Insert Person Damage
INSERT INTO person_damage (earthquake_id, person_id, name, injury_type, status)
VALUES (ba275b5c-8ddf-4499-b1b8-594f6757053a, now(), 'Maria Gonzalez', 'Broken arm', 'Injured');

INSERT INTO person_damage (earthquake_id, person_id, name, injury_type, status)
VALUES (0623ca47-47db-4c97-8ce6-b67b8163ac15, now(), 'John Doe', 'Head trauma', 'Critical');


-- New Mexico
INSERT INTO earthquake_by_location (location, event_time, id, magnitude)
VALUES ('New Mexico', '2011-02-03 04:05+0000', def664be-d66f-4769-8d09-b6387d1b5581, 5.1);

-- San Francisco
INSERT INTO earthquake_by_location (location, event_time, id, magnitude)
VALUES ('San Francisco', '2025-02-24 04:05+0000',  857beab3-b7fe-4276-a64c-50c29de5b903, 5.8)
USING TTL 604800;

INSERT INTO earthquake_by_location (location, event_time, id, magnitude)
VALUES ('San Francisco', toTimestamp(now()), 0623ca47-47db-4c97-8ce6-b67b8163ac15, 5.2);

-- Los Angeles
INSERT INTO earthquake_by_location (location, event_time, id, magnitude)
VALUES ('Los Angeles', '2025-01-30 04:05+0000', ff49457c-cf7f-4705-b38b-1ec0079e741c , 4.7);

INSERT INTO earthquake_by_location (location, event_time, id, magnitude)
VALUES ('Los Angeles', toTimestamp(now()), ba275b5c-8ddf-4499-b1b8-594f6757053a, 3.9);


-- Query: Get latest 2 earthquakes in Los Angeles
SELECT * FROM earth_info WHERE city = 'Los Angeles' LIMIT 2;