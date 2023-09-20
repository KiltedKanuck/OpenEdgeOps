#!/bin/bash

# env vars
echo "DOCKER_REPO_URL=${DOCKER_REPO_URL}"
echo "OE_VERSION=${OE_VERSION}"
echo "APP_NAME=${APP_NAME}"
echo "APP_VERSION=${APP_VERSION}"
echo "APP_GROUP=${APP_GROUP}"

# undeploy
PAS_INSTANCE_NAME=oepas1
docker-compose -p ${PAS_INSTANCE_NAME} down -v