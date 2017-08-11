#!/bin/bash

##
# Initializing needed services
##
if [[ "$BEHAT" == "1" ]]; then init-wordpress.sh $DB_NAME $DB_USER $DB_PASS $DB_HOST $WP_VERSION $WP_DIR; fi
if [[ "$BEHAT" == "1" ]]; then init-nginx.sh; fi
if [[ "$BEHAT" == "1" ]]; then init-selenium.sh; fi

##
# Copy Plugin to WordPress Direcotry
##
cd ..
cp -r "$PLUGIN_SLUG" "$WP_DIR/wp-content/plugins/$PLUGIN_SLUG"
cd "$PLUGIN_SLUG"
wp plugin activate $PLUGIN_SLUG --path=$WP_DIR