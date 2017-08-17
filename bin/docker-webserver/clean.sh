#!/bin/sh

echo "This will delete attached docker containers, mapped directories and evetually added data. Do you want to continue (y/n)? "
read ANSWER

if echo "$ANSWER" | grep -iq "^y" ;then

    echo "Start cleaning up project..."

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
    docker-compose -f "${BIN_PATH}/docker-compose.yml" down
    docker rmi -f $(docker images | grep dockerwebserver_ | tr -s ' ' | cut -d ' ' -f 3)

    # Removing directories
    rm -rf "${PLUGIN_PATH}/wordpress"
    rm -rf "${PLUGIN_PATH}/log"

    echo "Cleaned up project!"

else
    echo "Stopped cleaning up."
    exit 1;
fi