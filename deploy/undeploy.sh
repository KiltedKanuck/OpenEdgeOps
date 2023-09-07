#!/bin/bash

PAS_INSTANCE_NAME=oepas1
docker-compose -p ${PAS_INSTANCE_NAME} down -v
echo "Removed '${PAS_INSTANCE_NAME}_dc'"