# Используем официальный образ PostgreSQL
FROM postgres:latest

# Устанавливаем переменные окружения для PostgreSQL
ENV POSTGRES_DB=usefultraining
ENV POSTGRES_USER=trainingdb
ENV POSTGRES_PASSWORD=8RD5v4fiPza0$

# Копируем исходный .sql скрипт в контейнер
#COPY init.sql /docker-entrypoint-initdb.d/

# Экспонируем порт PostgreSQL
EXPOSE 5432