# CassandraRealTime
This project will utilize Apache Cassandra to store real-time earthquake data using the USGS API. We will demonstrate how Cassandra excels in handling time-series data through queries. 

---

## Overview

**System** Apache Cassandra version 4.x
**Purpose** Fetch earthquakes per location and time
**Group** Team 5 - Phase 2

### Purpose

Our goal in this project is to show where _Cassandra outperforms MySQL_, in particularly working with _time-series_ data. In this case using earthquakes logged by time and location. 


### Displayed Strengths of Cassandra
- No need for indexes or joins
- Automatically partitioned by location, sorted by time
- Scales efficiently with large datasets

---

## How to Run Our Project

We use **Docker** to run Cassandra, which uses containers to keep us from having to install locally. In order to install, you can follow these few steps: 

---

### Windows Setup

> 💡 If you get stuck, check out this helpful [setup video](https://www.youtube.com/watch?v=ZyBBv1JmnWQ&ab_channel=CodeBear)

#### 1. Download Docker Desktop  
Visit [Docker Desktop](https://www.docker.com/products/docker-desktop/) and install based on your Windows system architecture.

#### 2. Open Docker Desktop  
Make sure Docker is running.

#### 3. Pull the Cassandra Image

```bash
docker pull cassandra
```

#### 4. Confirm Image

```bash
docker images
```

#### 5. Run Cassandra + Open the Shell

```bash
docker-compose up -d
docker exec -it cassandra cqlsh
```

### Mac Setup 

#### 1. Install Docker + Docker Compose (via Homebrew)
- Run these commands through a terminal (make sure to have [homebrew](https://brew.sh/) installed)

```bash
brew install docker
brew install docker-compose
```

#### 2. Verify the Installation

```bash
docker --version
docker-compose --version
```

#### 3. Start Cassandra Container

From the project directory (where the `docker-compose.yml` is located), run: 

```bash 
docker-compose up -d
```

#### 4. Access the Cassandra Shell

Once our container is running, you can enter the Cassandra shell with: 

```bash 
docker exec -it cassandra cqlsh
```

---

## Running the Demo

1. Inside the Cassandra shell, run the setup script:

```bash
source 'create.cql';
```

2. Add test data and query it with:

```bash
source 'testqueries.cql';
```

This will create the keyspace, define the table, and insert sample earthquakes for querying.

### References
- USGS API: https://earthquake.usgs.gov/fdsnws/event/1/
- Baeldung Cassandra Cheatsheet: https://www.baeldung.com/cassandra-query-cheat-sheet
- Tutorials: YouTube links in assignment

## ⚠️ Disclaimer
This project was created for academic/demo purposes. Please do not reuse, submit, or distribute this work as your own.
