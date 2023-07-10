FROM python:3.8

ENV PYTHONUNBUFFERED 1

RUN mkdir /kudelasz

WORKDIR /kudelasz

ADD . /kudelasz

RUN pip install -r requirements.txt