from .repositories import CredentialSourceRepository


class UnitOfWork:
    credential_source_repository: CredentialSourceRepository

    def __init__(self, session):
        self._session = session
        self.credential_source_repository = CredentialSourceRepository(session)
