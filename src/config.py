from os import environ
from pydantic import BaseModel

DATABASE_URL = environ["POSTGRES_URL"]
AUTH0_URL = environ["AUTH0_URL"]
