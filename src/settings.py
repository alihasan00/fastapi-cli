from functools import lru_cache
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    """Simple FastAPI settings for startup projects"""

    # Core Settings
    SECRET_KEY: str
    DEBUG: bool = True

    # Database
    DATABASE_URL: str = "sqlite+aiosqlite:///./db.sqlite3"

    # API Configuration
    PROJECT_NAME: str = "FastAPI App"
    API_V1_PREFIX: str = "/api/v1"

    # CORS - adjust origins for your frontend
    CORS_ORIGINS: list[str] = ["http://localhost:3000", "http://localhost:8000"]

    # Internationalization
    TIME_ZONE: str = "UTC"

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()
