#!/bin/bash

# Analytics Development Environment Setup Script

set -e

echo "🚀 Setting up Analytics Development Environment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop and try again."
    exit 1
fi

echo "✅ Docker is running"

# Start MySQL containers
echo "🐘 Starting MySQL containers..."
docker-compose up -d

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
sleep 10

# Check if containers are healthy
if docker-compose ps | grep -q "healthy"; then
    echo "✅ Database containers are healthy"
else
    echo "⚠️  Database containers may not be fully ready yet"
fi

# Build the application
echo "🔨 Building application..."
mvn clean compile

echo "✅ Development environment setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Run the application: mvn spring-boot:run -Dspring-boot.run.profiles=dev"
echo "2. Access the application at: http://localhost:8080"
echo "3. Check logs at: logs/analytics-dev.log"
echo ""
echo "🔧 Useful commands:"
echo "- Stop containers: docker-compose down"
echo "- View container logs: docker-compose logs -f"
echo "- Reset database: docker-compose down -v && docker-compose up -d"
