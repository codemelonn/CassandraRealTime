-- Create Database
CREATE DATABASE IF NOT EXISTS earthquakedata;
USE earthquakedata;


CREATE TABLE IF NOT EXISTS earthquake_by_day (
    id                  VARCHAR(100) PRIMARY KEY,
    date_occurred       DATE,
    time_occurred       DATETIME,
    magnitude           FLOAT,
    depth               FLOAT,
    region              VARCHAR(255),
    country             VARCHAR(255),
    latitude            DOUBLE,
    longitude           DOUBLE
);
