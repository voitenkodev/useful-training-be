#!/bin/bash

# Путь к файлу .env
ENV_FILE="../.env"

# Проверка наличия файла .env
if [ ! -f "$ENV_FILE" ]; then
  echo ".env file not found at $ENV_FILE"
  exit 1
fi

# Загрузка переменных из .env
export $(grep -v '^#' $ENV_FILE | xargs)

# Проверка обязательных переменных
if [[ -z "$POSTGRES_HOST" || -z "$POSTGRES_PORT" || -z "$POSTGRES_USERNAME" || -z "$POSTGRES_PASSWORD" || -z "$POSTGRES_DATABASE" || -z "$POSTGRES_CONTAINER_NAME" ]]; then
  echo "All environment variables must be set in .env"
  exit 1
fi

# Создание дампа базы данных
docker exec -t "$POSTGRES_CONTAINER_NAME" pg_dump -U "$POSTGRES_USERNAME" -d "$POSTGRES_DATABASE" --inserts --no-owner --no-acl > dump.sql

if [ $? -eq 0 ]; then
  echo "Database dump saved to dump.sql"
else
  echo "Failed to create database dump"
fi
