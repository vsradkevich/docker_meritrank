#!/bin/bash

# Define custom port
HOST_PORT=5433

# Build Docker image
docker build -t my_pg_meritrank_image .

# Run Docker container
docker run -d --name pg_meritrank_container -p $HOST_PORT:5432 \
  -e POSTGRES_USER=your_username \
  -e POSTGRES_PASSWORD=your_password \
  -e POSTGRES_DB=your_database \
  my_pg_meritrank_image

# Wait for PostgreSQL to start
sleep 5

# Disable default insecure authentication
docker exec -it pg_meritrank_container bash -c "echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/postgresql.conf"

# Restart PostgreSQL
docker exec -it pg_meritrank_container service postgresql restart

# Create the necessary database objects
docker exec -it pg_meritrank_container psql -U your_username -d your_database -c "CREATE EXTENSION IF NOT EXISTS pg_meritrank;"

echo "Setup completed successfully!"

