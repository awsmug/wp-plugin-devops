#!/bin/sh

echo "Stopping webserver"

docker-compose -f "${PLUGIN_PATH}/docker-compose.yml" down

rmdir ${PLUGIN_PATH}/wordpress

echo "Finished stopping webserver!"

