#!/bin/sh

echo "This will delete attached docker containers and mapped directories. Do you want to continue (y/n)? " read ANSWER

if echo "$ANSWER" | grep -iq "^y" ;then

    echo "Start cleaning up project..."

    # Stopping docker and cleaning files up
    docker-compose -f "${PLUGIN_PATH}/docker-compose.yml" down
    docker rm $(docker ps -a -q)
    docker rmi -f $(docker images | grep dockerwebserver_ | tr -s ' ' | cut -d ' ' -f 3)

    # Removing directories
    rm -rf "${PLUGIN_PATH}/wordpress"
    rm -rf "${PLUGIN_PATH}/log"

    echo "Cleaned up project!"

else
    echo "Stopped cleaning up."
    exit 1;
fi