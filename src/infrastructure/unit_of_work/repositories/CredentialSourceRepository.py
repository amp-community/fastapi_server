from .BaseRepository import BaseRepository
from ....entities import CredentialSource


class CredentialSourceRepository(BaseRepository):
    def get_all(self):
        return self._session.query(CredentialSource).all()
