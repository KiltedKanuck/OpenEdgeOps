#!/bin/bash

# Start-up script for PAS for OpenEdge (PASOE) Docker container.
# Creates, deploys and starts the PASOE server.
# Starts the FluentBit process, if 'FLUENTBIT_LOGGING=true'.

# ------------------------------------------------------------------------------------------------
# Environment variables provided with the Docker image:
#   DLC                 Path to PAS for OpenEdge installation (/psc/dlc)
# 
#   WRKDIR              Path to the Working directory (/psc/wrk)
# 
#   JAVA_HOME           Path to Java Development Kit (JDK) installation (/usr/java)
# 
# Environment variables to be provided:
#   INSTANCE_NAME       PAS for OpenEdge Instance name
# 
#   APP_NAME            (Optional) Aplication name, will be used if FluentBit logging is be enabled.
#                       This will get logged as a new field in each log entry
# 
#   FLUENTBIT_LOGGING   (Optional) If set to the string 'true', FluentBit logging will be enabled
#                       Example: FLUENTBIT_LOGGING="true"
# ------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------------------
# Artifacts to be provided:
#   License             Should be provided at DLC location
#   (progress.cfg)
# 
#   Java Development    Should be installed at JAVA_HOME location
#   Kit (JDK)
#
#   <INSTANCE_NAME>.zip Should be provided at '/deploy/artifacts'
#                       This is the unit of deployment. Refer to the documentation for more details
# 
#   runtime.properties  (Optional) Should be provided at '/deploy/scripts/config' location.
#                       This can be used to provide runtime configurations.
#                       Example: <ABLAPP-NAME>.DB.CONNECTION.PARAMS=-db ...
# ------------------------------------------------------------------------------------------------

set -e

## Validations
# Validate if DLC is set
if [ -z ${DLC} ]; then echo "DLC is not set"; exit 1; fi

# Validate if WRKDIR is set
if [ -z ${WRKDIR} ]; then echo "WRKDIR is not set"; exit 1; fi

# Validate if license is provided
if [ ! -s ${DLC}/progress.cfg ]; then echo "License is not provided at ${DLC}"; exit 1; fi

# Validate if JAVA is present
if [ -z ${JAVA_HOME} ]; then echo "JAVA_HOME is not set"; exit 1;
elif [ ! -x "${JAVA_HOME}/bin/java" ]; then echo "JAVA not found at ${JAVA_HOME}"; exit 1; fi

# Validate if INSTANCE_NAME is set
if [ -z ${INSTANCE_NAME} ]; then echo "INSTANCE_NAME is not set"; exit 1; fi

# Validate if <INSTANCE_NAME>.zip is provided
if [ ! -s "/deploy/artifacts/${INSTANCE_NAME}.tar.gz" ]; then echo "'${INSTANCE_NAME}.tar.gz' is not provided at '/deploy/artifacts'"; exit 1; fi

## Create directory for additional log files 
LOG_PATH=/psc/wrk/logs
mkdir -p ${LOG_PATH}

## extract instance archive
cd ${WRKDIR}
mkdir -p tmp
tar -xzf /deploy/artifacts/${INSTANCE_NAME}.tar.gz -C tmp

## Start PASOE server
${DLC}/bin/pasman create -v -Z pas -u admin:admin ${INSTANCE_NAME}
${INSTANCE_NAME}/bin/tcman.sh import -v tmp/ablapps/Sports.oear
${INSTANCE_NAME}/bin/tcman.sh start

cd /deploy/scripts
# ant -f ./build.xml -DINSTANCE.ARCHIVE.FILE.ROOT=../artifacts/ deployAndStartInstance -l ${LOG_PATH}/start-server.log

# SIGTERM is issued by Docker commands (docker stop or docker-compose down)
# Adding a trap for the SIGTERM signal. i.e., to stop PASOE before stopping container
# not_done is a temporary flag
trap 'rm /tmp/not_done; ant -f ./build.xml stopInstance; sleep 10' SIGTERM

wait_for_sigterm() {
  # Loop until not_done flag is removed
  touch /tmp/not_done
  while [ -f /tmp/not_done ]
  do
      sleep 60 &
      wait $!  # This is required such that a trap on main process is triggered
  done
}

## Start FluentBit, if 'FLUENTBIT_LOGGING=true'
if [ "${FLUENTBIT_LOGGING}" = "true" ]
then
    export FLUENT_CONFIG_PATH=/etc/fluent-bit
    sh /deploy/scripts/setup-fluentbit.sh
    /usr/local/bin/fluent-bit -c ${FLUENT_CONFIG_PATH}/fluent-bit.conf -l ${LOG_PATH}/fluent-bit.log &
    wait_for_sigterm
else
    wait_for_sigterm
fi