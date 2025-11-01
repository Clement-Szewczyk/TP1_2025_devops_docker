#!/bin/bash

cat > docker-compose.yml << 'EOF'
version: '3.8'

services:

  postgres:
    image: postgres:16-alpine
    container_name: microservices-postgres
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: microservices
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - microservices-network

  redis:
    image: redis:7-alpine
    container_name: microservices-redis
    ports:
      - "6379:6379"
    networks:
      - microservices-network

  api:
    build:
      context: ./microservices-app/api
      dockerfile: Dockerfile
    container_name: microservices-api
    ports:
      - "4000:4000"
    environment:
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: postgres
      DB_PASSWORD: postgres
      DB_NAME: microservices
      REDIS_HOST: redis
      REDIS_PORT: 6379
      NODE_ENV: production
    depends_on:
      - postgres
      - redis
    networks:
      - microservices-network
   

  worker:
    build:
      context: ./microservices-app/worker
      dockerfile: Dockerfile
    container_name: microservices-worker
    environment:
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: postgres
      DB_PASSWORD: postgres
      DB_NAME: microservices
      REDIS_HOST: redis
      REDIS_PORT: 6379
    depends_on:
      - postgres
      - redis
    networks:
      - microservices-network
    restart: unless-stopped

networks:
  microservices-network:
    driver: bridge

volumes:
  postgres_data:
EOF

docker compose up -d

