# ELT Pipeline for Fractured Data

This project provides a simple pipeline structure for diversified, unstructured and fractured data. The main goal is to use the ELT (extract, load and transform) method to unify data from various data sources. It extracts data from multiple sources, such as APIs, CSV files and Excel files, loads them in the raw format into datalake (Postgres) from which it will be transformed into a unified format and stored in the warehouse DB (Postgres). Cleansed and transformed data are ready to be used as input for analytical processes.

## Overview

The pipeline is designed to:
- **Extract** data from various sources (APIs, CSV files, Excel files).  
- **Load** the raw data into a **Postgres data lake**.  
- **Transform** the data into a unified structure using **Airflow** and **dbt**, and store it in a **Postgres data warehouse**.  

Cleansed and transformed datasets are prepared for downstream **analytics and reporting**.

## Features

- **Dockerized environment** with `docker-compose` for reproducibility and portability.  
- **Data lake and warehouse** both hosted in Postgres.  
- **Airflow DAGs** to orchestrate extraction, loading, and transformation steps.  
- **dbt** models for transformations and data quality testing.  
- Connection and environment configuration with `.env`, `servers.json`, and `create_connections.sh`.  
- `init.sql` for database initialization.  


## Requirements

- Docker  
- Docker Compose  


## Getting Started

1. **Clone the repository**  
   bash
   git clone <your-repo-url>
   cd <your-repo-name>


2. **Set up environment variables**
   Create a `.env` file based on the provided template (if available) and update values as needed.

3. **Initialize connections**

   ```bash
   bash scripts/create_connections.sh
   ```

4. **Start the services**

   ```bash
   docker-compose up -d
   ```

5. **Access services**

   * Airflow UI: [http://localhost:8080](http://localhost:8080)
   * Postgres Data Lake & Warehouse: via configured ports


## Data Flow

1. **Extract**
   Pull raw data from APIs, CSV, and Excel sources.

2. **Load**
   Store raw data directly into the Postgres **data lake**.

3. **Transform**

   * Run Airflow DAGs to trigger dbt models.
   * dbt applies business logic, unifies schemas, and performs data quality tests.
   * Results are stored in the **data warehouse**.


## Data Quality

* dbt test framework is used to ensure data integrity.
* Tests cover schema consistency, uniqueness, null checks, and referential integrity.


## Future Improvements

* Add support for cloud storage (e.g., S3, GCS) as additional raw data sources.
* Implement monitoring/alerting for pipeline health.
* Extend dbt testing suite with business-level validations.
