#!/usr/bin/env bash

JC_DOCKER_REPO="kellybrazil"
JC_DOCKER_IMAGE_NAME="jc-restapi"
JC_DOCKER_IMAGE_VERSION="1.0"
JC_LIB_VERSION="1.23.6"

docker build \
    --tag "$JC_DOCKER_REPO"/"$JC_DOCKER_IMAGE_NAME":"$JC_DOCKER_IMAGE_VERSION" \
    --build-arg PYTHON_RUNTIME_VERSION="$(cut -d '-' -f 2 ./runtime.txt)" \
    --build-arg JC_DOCKER_IMAGE_VERSION="$JC_DOCKER_IMAGE_VERSION" \
    --build-arg JC_LIB_VERSION="$JC_LIB_VERSION" .
