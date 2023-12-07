#!/usr/bin/env bash

# `REPOSITORY` in `docker images`
JC_DOCKER_LOCAL_REPO="jc"
# Before `/`
JC_DOCKER_IMAGE_NAME="$(grep name ./render.yaml | awk '{print $2}')"
# After `:`
. ./.env

docker build \
    --tag "$JC_DOCKER_LOCAL_REPO"/"$JC_DOCKER_IMAGE_NAME":"$JC_DOCKER_IMAGE_VERSION" \
    --build-arg PYTHON_RUNTIME_VERSION="$(cut -d '-' -f 2 ./runtime.txt)" \
    --build-arg LABEL_VERSION="$JC_DOCKER_IMAGE_VERSION" .
