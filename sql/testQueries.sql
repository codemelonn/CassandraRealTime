USE earthquakedata; 


-- 1. Select 5 earthquakes on a known active date
SELECT * FROM earthquake_by_day
WHERE date_occurred = '2015-12-04'
LIMIT 5;

-- 2. Find the first 5 earthquakes on that same day, sorted by time
SELECT * FROM earthquake_by_day
WHERE date_occurred = '2015-12-04'
ORDER BY time_occurred ASC
LIMIT 5;

-- 3. Filter by country and magnitude (Alaska, magnitude > 1.0)
SELECT * FROM earthquake_by_day
WHERE date_occurred = '2015-12-04'
  AND country = 'Alaska'
  AND magnitude > 1.0
LIMIT 5;

-- 4. Filter by magnitude and depth (mag > 1.5 and depth > 5)
SELECT * FROM earthquake_by_day
WHERE date_occurred = '2015-12-04'
  AND magnitude > 1.5
  AND depth > 5
LIMIT 5;

-- 5. Filter by region using exact match
SELECT * FROM earthquake_by_day
WHERE date_occurred = '2015-12-04'
  AND region = '17 km NNW of Bridgeport'
LIMIT 5;


