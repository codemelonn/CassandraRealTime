--looks of the tables
select*
from earth_info;

select *
from earthquake_damage;

select *
from person_damage;

 
-- Query 1: Get all damages for a specific earthquake (Partition Key query)
SELECT damage_type, estimated_cost 
FROM earthquake_damage 
WHERE earthquake_id = ba275b5c-8ddf-4499-b1b8-594f6757053a;



-- Query 2: Get all people injured in a specific earthquake
SELECT name, injury_type, status
FROM person_damage
WHERE earthquake_id = ba275b5c-8ddf-4499-b1b8-594f6757053a;


-- Query 3: Get recent earthquakes in Los Angeles (not allowed directly!)
SELECT * FROM earth_info
WHERE location = 'Los Angeles' LIMIT 2;

-- Query 4: Insert TTL data (Auto-expiring)
INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES (uuid(), toTimestamp(now()), 'Temporary Location', 4.2)
USING TTL 86400;

select*
from earth_info;