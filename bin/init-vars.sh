#!/bin/bash

export PROJECT_DIR=$(dirname $(pwd))
export BIN_PATH=$(pwd)
export PATH=$PATH:$PROJECT_DIR/vendor/bin:$BIN_PATH
export NGINX_DIR=/tmp
export WP_DIR="/tmp/wordpress/"
export PLUGIN_DIR=$PROJECT_DIR
export PLUGIN_SLUG=$(basename $(pwd))
export DB_NAME="wordpress"
export DB_USER="root"
export DB_PASS="root"
export DB_HOST="localhost"