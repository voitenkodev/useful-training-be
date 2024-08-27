#!/bin/bash

ENV_FILE="../.env"

if [ ! -f "$ENV_FILE" ]; then
  echo ".env file not found at $ENV_FILE"
  exit 1
fi

# Load variables from .env
export $(grep -v '^#' $ENV_FILE | xargs)

# Check that all necessary variables are set
if [[ -z "$POSTGRES_HOST" || -z "$POSTGRES_PORT" || -z "$POSTGRES_USERNAME" || -z "$POSTGRES_PASSWORD" || -z "$POSTGRES_DATABASE" || -z "$POSTGRES_CONTAINER_NAME" ]]; then
  echo "All environment variables must be set in .env"
  exit 1
fi

# Start Docker container
docker-compose -f docker-compose.yml up -d

# Wait for the PostgreSQL container to be ready
echo "Waiting for PostgreSQL to start..."
sleep 10

# Dump the database to the current directory
docker exec "$POSTGRES_CONTAINER_NAME" pg_dump -h "$POSTGRES_HOST" -U "$POSTGRES_USERNAME" "$POSTGRES_DATABASE" > dump.sql

echo "Database dump saved to dump.sql"