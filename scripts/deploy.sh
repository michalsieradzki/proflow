#!/bin/bash

# PROFLOW Deployment Script
set -e

PROJECT_DIR="/var/www/proflow"
REPO_URL="https://github.com/michalsieradzki/proflow.git"
BRANCH="main"

echo "🚀 Starting PROFLOW deployment..."

# Create directory if it doesn't exist
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR

# Pull latest changes or clone if first time
echo "📥 Getting latest code..."
if [ ! -d ".git" ]; then
    echo "Cloning repository for first time..."
    git clone $REPO_URL .
else
    echo "Pulling latest changes..."
    git fetch origin
    git reset --hard origin/$BRANCH
fi

# Setup environment file
echo "⚙️ Setting up environment..."
if [ ! -f ".env" ]; then
    echo "🔑 Creating .env with secure credentials..."
    
    # Generate random passwords
    ROOT_PASSWORD=$(openssl rand -base64 32 | tr -d "=+/" | cut -c1-25)
    DB_PASSWORD=$(openssl rand -base64 32 | tr -d "=+/" | cut -c1-25)
    SECRET_KEY=$(openssl rand -hex 64)
    
    cat > .env << EOF
# Database Configuration
MYSQL_ROOT_PASSWORD=${ROOT_PASSWORD}
MYSQL_DATABASE=proflow_production
MYSQL_USER=proflow_admin
MYSQL_PASSWORD=${DB_PASSWORD}

# Rails Configuration
RAILS_ENV=production
SECRET_KEY_BASE=${SECRET_KEY}
RAILS_SERVE_STATIC_FILES=true
RAILS_LOG_TO_STDOUT=true
EOF

    echo "✅ .env file created with random secure passwords"
    echo "📋 Database credentials:"
    echo "   Root password: ${ROOT_PASSWORD}"
    echo "   DB user: proflow_admin"
    echo "   DB password: ${DB_PASSWORD}"
    echo "   Database: proflow_production"
    echo ""
    echo "💾 Save these credentials securely!"
else
    echo "✅ .env file already exists, using existing configuration"
fi

# Make scripts executable
chmod +x scripts/*.sh

# Stop services if running
echo "🛑 Stopping existing services..."
docker-compose -f docker-compose.prod.yml down || true

# Build and start services
echo "🐳 Building and starting services..."
docker-compose -f docker-compose.prod.yml build --no-cache
docker-compose -f docker-compose.prod.yml up -d

# Wait for database
echo "⏳ Waiting for database to be ready..."
sleep 30

# Run database setup
echo "🗄️ Setting up database..."
docker-compose -f docker-compose.prod.yml exec -T web bundle exec rails db:create || true
docker-compose -f docker-compose.prod.yml exec -T web bundle exec rails db:migrate

# Create admin user (bez db:seed żeby nie robić duplikatów)
echo "👤 Ensuring admin user exists..."
docker-compose -f docker-compose.prod.yml exec -T web bundle exec rails runner "
  unless User.exists?(email: 'admin@proflow.app')
    User.create!(
      email: 'admin@proflow.app',
      password: 'ProFlow2024!',
      password_confirmation: 'ProFlow2024!',
      role: 'super_admin',
      first_name: 'Admin',
      last_name: 'User'
    )
    puts 'Admin user created!'
  else
    puts 'Admin user already exists'
  end
"

echo ""
echo "✅ Deployment complete!"
echo "🌐 App running at http://$(hostname -I | awk '{print $1}'):3000"
echo "👤 Admin login: admin@proflow.app / ProFlow2024!"
echo ""
echo "📋 Useful commands:"
echo "  Check status: docker-compose -f docker-compose.prod.yml ps"
echo "  View logs: docker-compose -f docker-compose.prod.yml logs -f"
echo "  Connect to DB: docker-compose -f docker-compose.prod.yml exec db mysql -u proflow_admin -p proflow_production"
echo ""
echo "🔐 Your database credentials are stored in .env file" 