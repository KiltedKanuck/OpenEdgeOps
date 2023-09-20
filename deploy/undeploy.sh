#!/bin/bash

# env vars
export DOCKER_REPO_URL=${DOCKER_REPO_URL}
export OE_VERSION=${OE_VERSION}
export APP_NAME=${APP_NAME}
export APP_VERSION=${APP_VERSION}
export APP_GROUP=${APP_GROUP}

# undeploy
PAS_INSTANCE_NAME=oepas1
docker-compose -p ${PAS_INSTANCE_NAME} down -v
echo "Removed '${PAS_INSTANCE_NAME}_dc'"