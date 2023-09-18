#!/bin/bash

cat /psc/dlc/image-version
echo "APP_LOCATION: ${APP_LOCATION}"

echo "Building app at ${APP_LOCATION}!"
cd ${APP_LOCATION}
./gradlew clean build
echo "Building app at ${APP_LOCATION} completed!"
