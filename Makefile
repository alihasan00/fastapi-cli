.PHONY: dev run startapp secret-key makemigrations migrate showmigrations sqlmigrate dbshell alembic-init

dev:
	fastapi dev main.py

run:
	fastapi run main.py

secret-key:
	@python -c "import secrets; print('SECRET_KEY=' + secrets.token_urlsafe(64))"

startapp:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make startapp <app_name>"; \
		exit 1; \
	fi
	@APP_NAME=$(filter-out $@,$(MAKECMDGOALS)); \
	mkdir -p $$APP_NAME; \
	echo "from sqlmodel import SQLModel, Field\n\n" > $$APP_NAME/models.py; \
	echo "from pydantic import BaseModel\n\n" > $$APP_NAME/schemas.py; \
	echo "from fastapi import APIRouter\n\nrouter = APIRouter(prefix=\"/$$APP_NAME\", tags=[\"$$APP_NAME\"])\n" > $$APP_NAME/routers.py; \
	echo "import pytest\nfrom fastapi.testclient import TestClient\n\n" > $$APP_NAME/tests.py

# Django-style database migration commands
alembic-init:
	@if [ -d "alembic" ]; then \
		echo "Error: alembic directory already exists!"; \
		echo "Remove it first if you want to reinitialize."; \
		exit 1; \
	fi
	@echo "Initializing Alembic..."; \
	alembic init alembic; \
	echo ""; \
	echo "✓ Alembic initialized successfully!"; \
	echo ""; \
	echo "Next steps:"; \
	echo "1. Update alembic/env.py to import your models"; \
	echo "2. Update alembic.ini with your database URL"; \
	echo "3. Run: make makemigrations 'initial migration'"

makemigrations:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make makemigrations <message>"; \
		echo "Example: make makemigrations add_user_table"; \
		exit 1; \
	fi
	@MSG="$(filter-out $@,$(MAKECMDGOALS))"; \
	alembic revision --autogenerate -m "$$MSG"

migrate:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		alembic upgrade head; \
	else \
		alembic upgrade $(filter-out $@,$(MAKECMDGOALS)); \
	fi

showmigrations:
	@alembic history --verbose

sqlmigrate:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make sqlmigrate <revision>"; \
		echo "Shows the SQL for a specific migration"; \
		exit 1; \
	fi
	@REV="$(filter-out $@,$(MAKECMDGOALS))"; \
	alembic upgrade $$REV --sql

dbshell:
	@if command -v sqlite3 > /dev/null; then \
		sqlite3 db.sqlite3; \
	else \
		echo "sqlite3 not found. Install it to use dbshell."; \
		exit 1; \
	fi

%:
	@:
