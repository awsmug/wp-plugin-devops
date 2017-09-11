#!/bin/bash

if [ $# -lt 3 ]; then
  echo "usage: $0 <db-name> <db-user> <db-pass> <db-host> <wp-version> <wp-dir>"
  exit 1
fi

DB_NAME=$1
DB_USER=$2
DB_PASS=$3
DB_HOST=${4-localhost}
WP_VERSION=${5-latest}
WP_DIR=${6-/tmp/wordpress}

travis-wordpress.sh $DB_NAME $DB_USER $DB_PASS $DB_HOST $WP_VERSION $WP_DIR
travis-nginx.sh
travis-selenium.sh