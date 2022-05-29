FROM python:3.11.0b1-alpine3.15
RUN apk add --no-cache mariadb-dev build-base
RUN apk add --no-cache mysql mysql-client

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=app.py

EXPOSE 8083

CMD flask run --host=0.0.0.0 --port=8083 