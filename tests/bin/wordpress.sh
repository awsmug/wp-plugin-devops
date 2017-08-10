#!/bin/bash

# Exit if anything fails AND echo each command before executing.
# http://www.peterbe.com/plog/set-ex
set -ex

if [ $# -lt 3 ]; then
  echo "usage: $0 <db-name> <db-user> <db-pass> [db-host] [wp-version]"
  exit 1
fi

DB_NAME=$1
DB_USER=$2
DB_PASS=$3
DB_HOST=${4-localhost}
WP_VERSION=${5-latest}
WP_DIR=${WP_DIR-/tmp/wordpress}

# Download.
mkdir -p $WP_DIR
wp core download --force --version=$WP_VERSION --path=$WP_DIR

# Create config.
rm -f ${WP_DIR}wp-config.php
./vendor/bin/wp core config --path=$WP_DIR --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST

# Install.
./vendor/bin/wp db create --path=$WP_DIR
./vendor/bin/wp core install --path=$WP_DIR --url="wordpress.dev:8080" --title="wordpress.dev" --admin_user="admin" --admin_password="password" --admin_email="admin@wp.dev"
