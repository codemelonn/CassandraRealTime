##looks of the tables
select*
from earth_info;

select *
from earthquake_damage;

select *
from person_damage;


##get all damages for a specific earthquake
SELECT ei.location, ed.damage_type, ed.estimated_cost
FROM earth_info ei
JOIN earthquake_damage ed ON ei.id = ed.earthquake_id
WHERE ei.id = 'ba275b5c-8ddf-4499-b1b8-594f6757053a';


SELECT ei.location, ed.damage_type, ed.estimated_cost
FROM earth_info ei , earthquake_damage ed
WHERE ei.id = ed.earthquake_id and ei.id = 'ba275b5c-8ddf-4499-b1b8-594f6757053a';


##cost of damages to Los Angeles
SELECT ei.location, SUM(ed.estimated_cost) AS total_cost
FROM earth_info ei, earthquake_damage ed 
where ei.id = ed.earthquake_id
GROUP BY ei.location;


##List earthquakes with more than 1 damage report
SELECT ei.*
FROM earth_info ei
WHERE ei.id IN (
    SELECT earthquake_id
    FROM earthquake_damage
    GROUP BY earthquake_id
    HAVING COUNT(*) > 1
);

##Earthquakes above magnitude 5 in California
SELECT * 
FROM earth_info
WHERE magnitude > 5 AND location LIKE '%San Francisco%';
