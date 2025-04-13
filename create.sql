-- Create Database
CREATE DATABASE IF NOT EXISTS earthquakes_demo;
USE earthquakes_demo;

CREATE TABLE IF NOT EXISTS earth_info (
    id CHAR(36) PRIMARY KEY,
    event_time DATETIME,
    location VARCHAR(255),
    magnitude FLOAT
);

-- Earthquake Damage
CREATE TABLE IF NOT EXISTS earthquake_damage (
    damage_id INT AUTO_INCREMENT PRIMARY KEY,
    earthquake_id CHAR(36),
    damage_type VARCHAR(255),
    estimated_cost DECIMAL(15,2),
    FOREIGN KEY (earthquake_id) REFERENCES earth_info(id)
);

-- Person Damage
CREATE TABLE IF NOT EXISTS person_damage (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    earthquake_id CHAR(36),
    name VARCHAR(255),
    injury_type VARCHAR(255),
    status VARCHAR(50),
    FOREIGN KEY (earthquake_id) REFERENCES earth_info(id)
);

-- Insert Earthquake Records
INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES (UUID(), '2011-02-03 04:05:00', 'New Mexico', 5.1);

INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES (UUID(), '2025-02-24 04:05:00', 'San Francisco', 5.8);

INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES (UUID(), '2025-01-30 04:05:00', 'Los Angeles', 4.7);

-- Specific UUIDs for reference in damage tables
INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES ('ba275b5c-8ddf-4499-b1b8-594f6757053a', NOW(), 'Los Angeles', 3.9);

INSERT INTO earth_info (id, event_time, location, magnitude)
VALUES ('0623ca47-47db-4c97-8ce6-b67b8163ac15', NOW(), 'San Francisco', 5.2);

-- Insert Damage Data
INSERT INTO earthquake_damage (earthquake_id, damage_type, estimated_cost)
VALUES ('ba275b5c-8ddf-4499-b1b8-594f6757053a', 'Collapsed buildings', 5000000.00);

INSERT INTO earthquake_damage (earthquake_id, damage_type, estimated_cost)
VALUES ('ba275b5c-8ddf-4499-b1b8-594f6757053a', 'Damaged roads', 1200000.00);

-- Insert Person Damage
INSERT INTO person_damage (earthquake_id, name, injury_type, status)
VALUES ('ba275b5c-8ddf-4499-b1b8-594f6757053a', 'Maria Gonzalez', 'Broken arm', 'Injured');