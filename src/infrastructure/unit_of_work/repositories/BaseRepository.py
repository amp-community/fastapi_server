from sqlalchemy.orm import Session


class BaseRepository:
    _session: Session

    def __init__(self, session: Session) -> None:
        self._session = session
