#!/bin/sh

echo "Starting development environment..."

docker-compose up -d

$BIN_PATH/init.sh