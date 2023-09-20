#!/bin/bash

# env vars
echo "DOCKER_REPO_URL=${DOCKER_REPO_URL}"
echo "OE_VERSION=${OE_VERSION}"
echo "APP_NAME=${APP_NAME}"
echo "APP_VERSION=${APP_VERSION}"
echo "APP_GROUP=${APP_GROUP}"

# create the app docker image
# docker build --no-cache -t sports:latest .

# deploy
PAS_INSTANCE_NAME=oepas1
docker-compose --verbose -p ${PAS_INSTANCE_NAME} up -d
