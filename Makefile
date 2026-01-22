.PHONY: dev run startapp

dev:
	fastapi dev main.py

run:
	fastapi run main.py

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

%:
	@:
