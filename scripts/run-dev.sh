#!/bin/bash

# Analytics Development Server Startup Script

set -e

echo "🚀 Starting Analytics Application in Development Mode..."

# Check if Docker containers are running
if ! docker-compose ps | grep -q "Up"; then
    echo "⚠️  Docker containers are not running. Starting them..."
    docker-compose up -d
    echo "⏳ Waiting for MySQL database to be ready..."
    sleep 15
fi

echo "🔧 Starting Spring Boot application with dev profile..."
echo "📝 Command: mvn spring-boot:run -Dspring-boot.run.profiles=dev"
echo ""

# Start the application
mvn spring-boot:run -Dspring-boot.run.profiles=dev
