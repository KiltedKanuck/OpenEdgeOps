#!/bin/bash

echo "Building Docker Image"
docker build -t webui:latest . --no-cache
echo "Building Docker Image complete!"