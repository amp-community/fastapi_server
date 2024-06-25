from typing import Annotated
from fastapi import Depends, FastAPI
from sqlalchemy.orm import Session
from .infrastructure import UnitOfWork, get_db

app = FastAPI()


@app.get("/healthcheck")
def healthcheck():
    return "Health - OK"


@app.get("/credentialSources")
def get_books(db: Session = Depends(get_db)):
    uow = UnitOfWork(db)
    return uow.credential_source_repository.get_all()