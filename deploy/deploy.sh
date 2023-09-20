#!/bin/bash


# env vars
export DOCKER_REPO_URL=${DOCKER_REPO_URL}
export OE_VERSION=${OE_VERSION}
export APP_NAME=${APP_NAME}
export APP_VERSION=${APP_VERSION}
export APP_GROUP=${APP_GROUP}

# create the app docker image
# docker build --no-cache -t sports:latest .

# deploy
PAS_INSTANCE_NAME=oepas1
docker-compose -p ${PAS_INSTANCE_NAME}  up -d
echo "PASOE instance named '${PAS_INSTANCE_NAME}_dc' will be available at 'https://localhost:8811'"