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

# Check if the container already exists
CONTAINER_EXISTS=$(docker ps -a --filter "name=${POSTGRES_CONTAINER_NAME}" --format "{{.Names}}")

if [ -z "$CONTAINER_EXISTS" ]; then
  echo "Container ${POSTGRES_CONTAINER_NAME} does not exist. Creating and starting a new container..."

  # Start Docker container and initialize the database from dump.sql
  docker-compose -f docker-compose.yml up -d

  # Wait for the PostgreSQL container to be ready
  echo "Waiting for PostgreSQL to start..."
  sleep 10

  echo "Database initialized from dump.sql"
else
  echo "Container ${POSTGRES_CONTAINER_NAME} already exists. Starting the container..."

  # Start the existing container
  docker start "$POSTGRES_CONTAINER_NAME"

  # Wait for the PostgreSQL container to be ready
  echo "Waiting for PostgreSQL to start..."
  sleep 10
fi

# Check the status of the container
if [ "$(docker inspect -f '{{.State.Running}}' "$POSTGRES_CONTAINER_NAME")" != "true" ]; then
  echo "Failed to start the PostgreSQL container."
  exit 1
fi

# Start the npm project
echo "Starting the npm project..."
npm start

echo "Project is running"