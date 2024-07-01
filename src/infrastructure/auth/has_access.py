from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from fastapi import Depends
from .jwt_decode import jwt_decode

security = HTTPBearer()


async def has_access(credentials: HTTPAuthorizationCredentials = Depends(security)):
    return jwt_decode(credentials.credentials)
