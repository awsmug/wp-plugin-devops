#!/bin/sh

# Get configuration
echo "Reading config...." >&2

if [ -f "${PLUGIN_PATH}/project.cfg" ]; then
    echo "Reading configuration file..." >&2
    source $PLUGIN_PATH/project.cfg
else
    echo "Failed: Configuration file not found!";
    exit 1
fi

# Stopping docker and cleaning files up
docker-compose down
docker rmi -f $(docker images | grep ${CONTAINER_PREFIX}_ | tr -s ' ' | cut -d ' ' -f 3)

# Removing directories
rm -rf "${PLUGIN_PATH}/wordpress"
rm -rf "${PLUGIN_PATH}/log"

echo "Cleaned up project!"