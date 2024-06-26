from jwt.jwk import RSAJWK
from jwt import JWT
from httpx import get
from jwt.exceptions import JWTDecodeError
from ...domain.exceptions import Unauthorized
from ...config import AUTH0_URL

JWKS = get(f"https://{AUTH0_URL}/.well-known/jwks.json").json()
rsa_jwt = RSAJWK.from_dict(JWKS["keys"][0])
jwt = JWT()


def jwt_decode(token: str):
    try:
        payload = jwt.decode(token, rsa_jwt)
        return payload
    except JWTDecodeError as e:
        raise Unauthorized("Invalid token")
