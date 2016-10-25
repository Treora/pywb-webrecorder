FROM python:2.7-alpine

RUN apk update
RUN apk add git build-base
RUN apk add linux-headers libffi-dev openssl-dev

WORKDIR /app

# We use multiple requirements-files to not invalidate the whole cache
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY requirements2.txt requirements2.txt
RUN pip install -r requirements2.txt

COPY . .

RUN chown -R 1234:123 /app
RUN mkdir -p /data/pywb && chown 1234:123 /data/pywb
USER 1234:123

VOLUME /data

EXPOSE 8080

CMD python pywb-webrecorder.py
