#!/bin/sh

echo "Reading config...." >&2
source ../config.cfg

docker-compose down

rm -rf wordpress
rm -rf log

echo "Cleaned up project!"