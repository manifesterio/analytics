-- Create additional databases for different environments
CREATE DATABASE IF NOT EXISTS analytics_test;
CREATE DATABASE IF NOT EXISTS analytics_prod;

-- Grant permissions to analytics_user for all databases
GRANT ALL PRIVILEGES ON analytics_dev.* TO 'analytics_user'@'%';
GRANT ALL PRIVILEGES ON analytics_test.* TO 'analytics_user'@'%';
GRANT ALL PRIVILEGES ON analytics_prod.* TO 'analytics_user'@'%';

-- Flush privileges to ensure changes take effect
FLUSH PRIVILEGES;
