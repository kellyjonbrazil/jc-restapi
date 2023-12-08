ARG BASE_DOCKER_IMAGE_NAME="python"
ARG PYTHON_RUNTIME_VERSION="3.9.13"
ARG DISTRO="alpine"
# FROM python:3.9.13-alpine
FROM ${BASE_DOCKER_IMAGE_NAME}:${PYTHON_RUNTIME_VERSION}-${DISTRO}

ARG APP_PORT=5000
ARG GUNICORN_PORT=8000
ARG APP_WORKDIR=/app

ARG LABEL_MAINTAINER="Kelly Brazil kellyjonbrazil@gmail.com"
ARG LABEL_VERSION="1.1"

LABEL maintainer=${LABEL_MAINTAINER}
LABEL version=${LABEL_VERSION}
LABEL description="Dockerized https://github.com/kellyjonbrazil/jc-restapi"

ENV PATH="${PATH}:/usr/local/bin"
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV GUNICORN_CMD_ARGS "--bind 0.0.0.0:${GUNICORN_PORT}"

# 4 HEALTHCHECK
RUN apk --no-cache add curl

WORKDIR ${APP_WORKDIR}
COPY . .
RUN pip install --no-cache --requirement requirements.txt

EXPOSE ${APP_PORT}
EXPOSE ${GUNICORN_PORT}

HEALTHCHECK \
    CMD \
    (curl --fail --head http://127.0.0.1:${APP_PORT}/v1/version && \
    curl --fail --head http://127.0.0.1:${GUNICORN_PORT}/v1/version) || \
    exit 1

# ENTRYPOINT ["python3", "app.py"]
ENTRYPOINT ["gunicorn", "app:app"]

# urls
# https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-18-04
# https://stackoverflow.com/a/67133443
# https://docs.gunicorn.org/en/stable/settings.html#settings
# https://testdriven.io/blog/dockerizing-flask-with-postgres-gunicorn-and-nginx/
# https://stackoverflow.com/a/32806333
# https://stackoverflow.com/a/68521032
# https://stackoverflow.com/a/38742545
