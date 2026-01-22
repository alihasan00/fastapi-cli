from sqlmodel.ext.asyncio.session import AsyncSession
from sqlalchemy.ext.asyncio import create_async_engine
from typing import AsyncGenerator

from src.settings import settings

engine = create_async_engine(settings.DATABASE_URL, echo=settings.DEBUG, future=True)


async def get_session() -> AsyncGenerator[AsyncSession, None]:
    async with AsyncSession(engine) as session:
        yield session
