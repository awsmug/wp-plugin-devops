#!/bin/sh

if [ "$1" = "all" ]; then
    $VENDOR_BIN_PATH/docker/phpunit-tests.sh
    $VENDOR_BIN_PATH/docker/behat-tests.sh
    echo "Starting all tests"

elif [ "$1" = "phpunit" ]; then
    $VENDOR_BIN_PATH/docker/phpunit-tests.sh
    echo "Starting PHP Unit Tests"

elif [ "$1" = "behat" ]; then
    $VENDOR_BIN_PATH/docker/behat-tests.sh
    echo "Starting Behat Tests"

else
    echo "Usage: wpdevops test <all|behat|phpunit>"
    exit 1
fi