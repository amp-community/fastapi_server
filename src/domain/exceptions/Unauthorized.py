from .HttpException import HttpException


class Unauthorized(HttpException):
    def __init__(self, message: str = "Non Authorize"):
        super().__init__(message, 401)
