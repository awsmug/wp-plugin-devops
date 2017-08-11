#!/bin/sh

echo $BEHAT

if [ $BEHAT == "1" ]; then wordpress.sh $DB_NAME $DB_USER $DB_PASS $DB_HOST $WP_VERSION $WP_DIR; fi
if [[ "$BEHAT" == "1" ]]; then nginx.sh; fi
if [[ "$BEHAT" == "1" ]]; then selenium.sh; fi
cd ..
cp -r "$PLUGIN_SLUG" "$WP_DIR/wp-content/plugins/$PLUGIN_SLUG"
cd "$PLUGIN_SLUG"
wp plugin activate $PLUGIN_SLUG --path=$WP_DIR