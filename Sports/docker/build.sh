#!/bin/bash

echo "Building Docker Image"
docker build -t ${APP_NAME}:${APP_VERSION} . --no-cache
echo "Building Docker Image Complete!"