#!/bin/bash

# PROFLOW Database Connection Script

if [ ! -f ".env" ]; then
    echo "❌ .env file not found! Run deployment first."
    exit 1
fi

# Load environment variables
source .env

echo "🗄️ Connecting to MySQL database..."
echo "Database: $MYSQL_DATABASE"
echo "User: $MYSQL_USER"
echo ""

docker-compose -f docker-compose.prod.yml exec db mysql -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE 