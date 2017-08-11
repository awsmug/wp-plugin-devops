#!/bin/bash

##
# Initializing needed services
##
if [[ "$BEHAT" == "1" ]]; then init-wordpress.sh $DB_NAME $DB_USER $DB_PASS $DB_HOST $WP_VERSION $WP_DIR; fi
if [[ "$BEHAT" == "1" ]]; then init-nginx.sh; fi
if [[ "$BEHAT" == "1" ]]; then init-selenium.sh; fi