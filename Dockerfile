ARG BASE_DOCKER_IMAGE_NAME="python"
ARG PYTHON_RUNTIME_VERSION
ARG DISTRO="alpine"

FROM ${BASE_DOCKER_IMAGE_NAME}:${PYTHON_RUNTIME_VERSION}-${DISTRO}

ARG JC_MAINTAINER="Kelly Brazil (kellyjonbrazil@gmail.com)"
ARG JC_DOCKER_IMAGE_VERSION
ARG JC_LIB_VERSION
ARG JC_DESCRIPTION="Dockerized https://github.com/kellyjonbrazil/jc-restapi"

LABEL maintainer="$JC_MAINTAINER"
LABEL version="$JC_DOCKER_IMAGE_VERSION"
LABEL jc_library_version="$JC_LIB_VERSION"
LABEL description="$JC_DESCRIPTION"

ENV JC_APP_PORT="8000"
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV GUNICORN_CMD_ARGS "--bind 0.0.0.0:${JC_APP_PORT}"

EXPOSE ${JC_APP_PORT}

WORKDIR /app
COPY app.py requirements.txt .
RUN apk --no-cache add curl && \
    pip install --no-cache --requirement requirements.txt

HEALTHCHECK --interval=5m --timeout=5s \
    CMD curl --fail http://127.0.0.1:${JC_APP_PORT}/v1/version || exit 1

ENTRYPOINT ["/usr/local/bin/gunicorn", "app:app"]
