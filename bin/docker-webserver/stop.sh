#!/bin/sh

echo "Stopping webserver"

docker-compose -f "${BIN_PATH}/docker-compose.yml" down

echo "Finished stopping webserver!"