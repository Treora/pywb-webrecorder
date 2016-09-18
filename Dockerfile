FROM python:2.7-alpine

RUN apk update
RUN apk add git build-base
RUN apk add linux-headers libffi-dev openssl-dev

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

VOLUME /data

EXPOSE 8080

CMD python pywb-webrecorder.py
