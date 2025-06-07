#!/bin/bash

# PROFLOW Database Backup Script

if [ ! -f ".env" ]; then
    echo "❌ .env file not found! Run deployment first."
    exit 1
fi

# Load environment variables
source .env

# Create backups directory
mkdir -p backups

# Generate backup filename
BACKUP_FILE="backups/proflow_backup_$(date +%Y%m%d_%H%M%S).sql"

echo "📦 Creating database backup..."
echo "File: $BACKUP_FILE"

docker-compose -f docker-compose.prod.yml exec -T db mysqldump -u root -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE > $BACKUP_FILE

echo "✅ Backup created successfully!"
echo "📄 Backup file: $BACKUP_FILE" 