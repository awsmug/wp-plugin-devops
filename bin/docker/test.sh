#!/bin/sh

if [ "$1" = "all" ]; then
    $BIN_DIR/docker/phpunit-tests.sh
    $BIN_DIR/docker/behat-tests.sh
    echo "Starting all tests"

elif [ "$1" = "phpunit" ]; then
    $BIN_DIR/docker/phpunit-tests.sh
    echo "Starting PHP Unit Tests"

elif [ "$1" = "behat" ]; then
    $BIN_DIR/docker/behat-tests.sh
    echo "Starting Behat Tests"

else
    echo "Usage: wpdevops test <all|behat|phpunit>"
    exit 1
fi