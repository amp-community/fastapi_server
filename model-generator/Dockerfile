FROM python:3.10 as base

WORKDIR /models

COPY ./requirements.txt .

RUN pip install -r ./requirements.txt
RUN mkdir /generated