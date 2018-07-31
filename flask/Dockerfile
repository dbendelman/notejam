FROM python:2.7.15-alpine3.6

CMD ["python", "./runserver.py"]
WORKDIR /src

COPY requirements.txt .
RUN set -ex; \
    apk add --update --no-cache --virtual build-dependencies \
        g++ \
        libressl-dev \
        libffi-dev \
        yaml-dev \
        mariadb-dev; \
    pip install --no-cache-dir -r requirements.txt; \
    apk add --no-cache \
        mariadb-client-libs; \
    apk del build-dependencies

COPY . .
