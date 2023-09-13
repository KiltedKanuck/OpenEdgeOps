#!/bin/bash

echo "Building Docker Image"
docker build -t sports:latest . --no-cache
echo "Building Docker Image Complete!"