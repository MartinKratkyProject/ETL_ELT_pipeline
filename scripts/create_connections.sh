#!/bin/bash

# Load environment variables from ../.env
ENV_FILE="$(dirname "$0")/../.env"

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

set -o allexport
source "$ENV_FILE"
set +o allexport

echo "Waiting for Airflow DB to be ready..."
airflow db upgrade

# Create internal (metrics) DB connection
WAREHOUSE_URI="postgresql+psycopg2://${WAREHOUSE_PG_USER}:${WAREHOUSE_PG_PASSWORD}@${WAREHOUSE_PG_HOST}:${WAREHOUSE_PG_PORT}/${WAREHOUSE_PG_DB}"

if ! airflow connections get 'postgres_default' &>/dev/null; then
    echo "Creating Postgres default connection..."
    airflow connections add 'postgres_default' --conn-uri "$WAREHOUSE_URI"
else
    echo "Postgres default connection already exists"
fi

if ! airflow connections get "$WAREHOUSE_PG_CONN_ID" &>/dev/null; then
    echo "Creating metrics Postgres connection..."
    airflow connections add "$WAREHOUSE_PG_CONN_ID" --conn-uri "$WAREHOUSE_URI"
else
    echo "Metrics Postgres connection already exists"
fi

if ! airflow connections get 'redis_default' &>/dev/null; then
    echo "Creating Redis connection..."
    airflow connections add 'redis_default' \
        --conn-uri 'redis://redis:6379'
else
    echo "Redis connection already exists"
fi

echo "Airflow connections ensured!"
echo "Setting Airflow Variables..."

airflow variables set warehouse_pg_conn_id "${WAREHOUSE_PG_CONN_ID:-warehouse_pg_conn}"

echo "Airflow Variables set!"
