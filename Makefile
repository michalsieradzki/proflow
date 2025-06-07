.PHONY: deploy logs restart status db-connect db-backup

deploy:
	./scripts/deploy.sh

logs:
	docker-compose -f docker-compose.prod.yml logs -f

restart:
	docker-compose -f docker-compose.prod.yml restart

status:
	docker-compose -f docker-compose.prod.yml ps

stop:
	docker-compose -f docker-compose.prod.yml down

db-connect:
	./scripts/db_connect.sh

db-backup:
	./scripts/db_backup.sh

help:
	@echo "Available commands:"
	@echo "  deploy     - Deploy latest version"
	@echo "  logs       - Show application logs"
	@echo "  restart    - Restart all services"
	@echo "  status     - Show services status"
	@echo "  stop       - Stop all services"
	@echo "  db-connect - Connect to MySQL database"
	@echo "  db-backup  - Create database backup" 