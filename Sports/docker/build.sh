#!/bin/bash

echo "Building Docker Image"
docker build -t ${IMAGE_NAME}:latest . --no-cache
echo "Building Docker Image Complete!"