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

### Configuration

#### `make secret-key`
Generates a cryptographically secure SECRET_KEY for your application.

```bash
make secret-key
```

This command:
- Generates a 64-byte (512-bit) random key using Python's `secrets` module
- Outputs in the format: `SECRET_KEY=<generated_key>`
- Produces a URL-safe base64-encoded string
- Suitable for production use in JWT tokens, session management, and encryption

**Usage:**
```bash
# Generate a new secret key
make secret-key

# Copy the output to your .env file
# Example output: SECRET_KEY=a1b2c3d4e5f6g7h8...
```

**Important:** 
- Always use a unique SECRET_KEY for each environment (development, staging, production)
- Never commit your SECRET_KEY to version control
- Store it securely in your `.env` file

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
