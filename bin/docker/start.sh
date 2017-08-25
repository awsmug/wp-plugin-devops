#!/bin/sh

echo "Starting development environment..."

docker-compose -f $DOCKER_COMPOSE_FILE up -d

$BIN_PATH/init.sh

echo "Finished starting webserver!"