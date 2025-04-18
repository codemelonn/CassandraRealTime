USE earthquakedata; 


-- Query 1: get all earthquakes on a specific day, sorted by time
SELECT * 
FROM earthquake_by_day
WHERE date_occurred = '2023-02-10'
LIMIT 40;


-- Query 2: find the earliest earthquake on a given day 
SELECT * 
FROM earthquake_by_day
WHERE date_occurred = '2023-03-10'
ORDER BY time_occurred ASC
LIMIT 1;


-- Query 3: get all earthquakes in a region on a day 
SELECT * FROM earthquake_by_day
WHERE date_occurred = '2023-04-02'
LIMIT 40;



-- Query 4: filter by magnitude on a given day 
SELECT * 
FROM earthquake_by_day
WHERE date_occurred = '2023-01-24' 
    AND magnitude > 5.0
    LIMIT 40;



-- Query 5: look up a specific earthquake on a known date 
SELECT * 
FROM earthquake_by_day
WHERE date_occurred = '2023-10-24'
    AND time_occurred = '2023-10-24 18:00:40'
    AND id = 'mb90030798';


