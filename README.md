# FastAPI Project

A FastAPI project with helpful Makefile commands for development and app scaffolding.

## Makefile Commands

### Development

#### `make dev`
Starts the FastAPI application in development mode with auto-reload enabled.

```bash
make dev
```

This command runs `fastapi dev main.py`, which:
- Enables auto-reload on code changes
- Provides detailed error messages
- Runs on the default development server

#### `make run`
Starts the FastAPI application in production mode.

```bash
make run
```

This command runs `fastapi run main.py`, which:
- Runs the application in production mode
- Optimized for performance
- No auto-reload functionality

### App Scaffolding

#### `make startapp <app_name>`
Creates a new app directory with a standard FastAPI structure.

```bash
make startapp users
```

This command creates a new directory with the following files:

- **`models.py`** - SQLModel models for database tables
- **`schemas.py`** - Pydantic schemas for request/response validation
- **`routers.py`** - FastAPI router with the app prefix and tags
- **`tests.py`** - Test file with pytest and TestClient imports

**Example:**
```bash
make startapp auth
```

Creates an `auth/` directory with:
```
auth/
├── models.py    # Database models
├── schemas.py   # Request/response schemas
├── routers.py   # API routes (prefix: /auth)
└── tests.py     # Unit tests
```

## Getting Started

1. Install dependencies:
```bash
uv sync
```

2. Start development server:
```bash
make dev
```

3. Create a new app module:
```bash
make startapp <your_app_name>
```
