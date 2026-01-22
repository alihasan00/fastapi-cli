from fastapi import FastAPI
from src.settings import settings

app = FastAPI(title=settings.PROJECT_NAME, version="0.1.0")
