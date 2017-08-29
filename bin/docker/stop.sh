#!/bin/sh

echo "Stopping webserver"

docker-compose -f "${PLUGIN_PATH}/docker-compose.yml" down

echo "Finished stopping webserver!"