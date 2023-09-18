#!/bin/bash

echo "Building Docker Image"
docker build -t openedge-dev-pasoe:12.8.0 . --no-cache
echo "Building Docker Image Complete!"