#!/bin/bash


# env vars
# export DOCKER_REPO_URL=${DOCKER_REPO_URL}
# export OE_VERSION=${OE_VERSION}
# export APP_NAME=${APP_NAME}
# export APP_VERSION=${APP_VERSION}
# export APP_GROUP=${APP_GROUP}

# export APP_GROUP=progress/rahulk
# export APP_NAME=sports
# export APP_VERSION=latest
# export DOCKER_REPO_URL=ec2-54-80-142-101.compute-1.amazonaws.com:9443
# export OE_VERSION=12.8.0

# create the app docker image
# docker build --no-cache -t sports:latest .

# deploy
PAS_INSTANCE_NAME=oepas1
docker-compose -p ${PAS_INSTANCE_NAME}  up -d
echo "PASOE instance named '${PAS_INSTANCE_NAME}_dc' will be available at 'https://localhost:8811'"