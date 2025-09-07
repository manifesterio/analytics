# Analytics Application - Development Setup

This guide will help you set up the local development environment for the Analytics application.

## Prerequisites

- Java 21
- Maven 3.6+
- Docker and Docker Compose
- Git

## Quick Start

### 1. Start the Database

```bash
# Start MySQL containers
docker-compose up -d

# Verify containers are running
docker-compose ps
```

### 2. Build and Run the Application

```bash
# Build the application
mvn clean compile

# Run with development profile (using script - recommended)
./scripts/run-dev.sh

# Or run directly with Maven
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

**Note**: Make sure to use `profiles` (plural), not `profile` (singular) in the Maven command.

### 3. Verify Setup

- Application should start on `http://localhost:8080`
- Database migrations will run automatically via Liquibase
- Check logs in `logs/analytics-dev.log`

## Environment Configuration

The application supports three environments:

- **dev**: Development environment (default)
- **test**: Testing environment  
- **prod**: Production environment

### Development Environment

- Database: `analytics_dev` on `localhost:3306`
- Logging: DEBUG level with console and file output
- SQL queries logged to console

### Test Environment

- Database: `analytics_test` on `localhost:3307`
- Logging: INFO level, minimal console output
- Optimized for test execution

### Production Environment

- Database: Uses environment variables (`DATABASE_URL`, `DATABASE_USERNAME`, `DATABASE_PASSWORD`)
- Logging: WARN level, file output only
- Optimized for performance

## Database Schema

The application uses Liquibase for database migrations. Initial schema includes:

- `users`: User management
- `projects`: Analytics projects
- `events`: Event tracking data

## Logging

Logs are configured via `logback-spring.xml`:

- **Development**: Console + file logging with DEBUG level
- **Test**: Minimal logging for test performance
- **Production**: File-only logging with WARN level

Log files are stored in the `logs/` directory:
- `analytics.log`: All application logs
- `analytics-error.log`: Error logs only

## Docker Commands

```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f mysql

# Reset database (removes all data)
docker-compose down -v
docker-compose up -d
```

## Troubleshooting

### Database Connection Issues

1. Ensure Docker containers are running:
   ```bash
   docker-compose ps
   ```

2. Check database connectivity:
   ```bash
   docker-compose exec mysql mysql -u analytics_user -panalytics_password -e "SELECT 1;"
   ```

### Application Startup Issues

1. Check application logs:
   ```bash
   tail -f logs/analytics-dev.log
   ```

2. Verify database migrations:
   ```bash
   docker-compose exec mysql mysql -u analytics_user -panalytics_password -e "SHOW TABLES;"
   ```

### Port Conflicts

If port 3306 is already in use, modify the port mapping in `docker-compose.yml`:

```yaml
ports:
  - "3308:3306"  # Change 3306 to 3308
```

Then update the database URL in `application.yml` accordingly.

## Test Coverage

The project uses JaCoCo for code coverage analysis:

### Generate Coverage Report
```bash
# Using the coverage script (recommended)
./scripts/coverage.sh

# Or using Maven directly
mvn clean test -Pcoverage
```

### View Coverage Reports
- **HTML Report**: `target/site/jacoco/index.html`
- **XML Report**: `target/site/jacoco/jacoco.xml` (for CI/CD integration)
- **CSV Report**: `target/site/jacoco/jacoco.csv`

### Coverage Thresholds
The project enforces minimum coverage thresholds:
- **Instruction Coverage**: 30% (will increase as more tests are added)
- **Branch Coverage**: 20% (will increase as more tests are added)

### Check Coverage Thresholds
```bash
# Check if coverage meets minimum thresholds
mvn test -Pcoverage-check
```

### Current Coverage Status
- **Instruction Coverage**: 37% (3/8)
- **Line Coverage**: 33% (1/3)  
- **Method Coverage**: 50% (1/2)

*Note: Current coverage is low as we only have basic application startup tests. Coverage will improve as more business logic and tests are added.*

## Development Workflow

1. Make code changes
2. Run tests: `mvn test`
3. Check coverage: `./scripts/coverage.sh`
4. Start application: `./scripts/run-dev.sh` (or `mvn spring-boot:run -Dspring-boot.run.profiles=dev`)
5. Test your changes
6. Commit and push

## Security Notes

- Default admin credentials: `admin/admin123` (change in production!)
- Database passwords are set in docker-compose.yml (use secrets in production)
- All sensitive configuration should use environment variables in production
