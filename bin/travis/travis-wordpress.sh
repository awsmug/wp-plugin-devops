#!/bin/bash

# Exit if anything fails AND echo each command before executing.
# http://www.peterbe.com/plog/set-ex
set -ex

if [ $# -lt 3 ]; then
  echo "usage: $0 <db-name> <db-user> <db-pass> <db-host> <wp-version> <wp-dir>"
  exit 1
fi

DB_NAME=$1
DB_USER=$2
DB_PASS=$3
DB_HOST=${4-localhost}
WP_VERSION=${5-latest}
WP_DIR=${6-${CURRENT_DIR}/wordpress}

# Download.
mkdir -p $WP_DIR
wp core download --force --version=$WP_VERSION --path=$WP_DIR

# Create config.
rm -f ${WP_DIR}wp-config.php
wp core config --path=$WP_DIR --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST

# Install.
wp db create --path=$WP_DIR
wp core install --path=$WP_DIR --url="wordpress" --title="wordpress" --admin_user="admin" --admin_password="admin" --admin_email="admin@wp.dev"
