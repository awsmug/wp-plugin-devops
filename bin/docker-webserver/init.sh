#!/bin/sh

echo "Try to initialize project..." >&2
#sleep 10

# Only initialize if not initialzed before
if [ -d "${PLUGIN_PATH}/logs" ]; then
    echo "Project already initialized!" >&2
    exit 0
fi

# Get configuration
if [ -f "$PLUGIN_PATH/project.cfg" ]; then
    echo "Reading configuration file..." >&2
    source $PLUGIN_PATH/project.cfg
else
    echo "Failed: Configuration file not found!";
    exit 1
fi

#Installing WordPress
WP_CONTAINER_NAME="${CONTAINER_PREFIX}_wordpress_1"

echo "Container: $WP_CONTAINER_NAME"

echo "Installing WordPress..."
docker exec ${WP_CONTAINER_NAME} wp core install --url=localhost --title=WPPlugin --admin_user=admin --admin_password=admin --admin_email=info@example.com --allow-root

#Installing plugins from config
for PLUGIN in  $(echo $REQUIRED_PLUGINS | sed "s/,/ /g"); do
    echo "Installing WordPress Plugin \"${WP_CONTAINER_NAME}\"..."
    docker exec ${WP_CONTAINER_NAME} wp plugin install $PLUGIN --allow-root && docker exec ${WP_CONTAINER_NAME} wp plugin activate $PLUGIN --allow-root
    docker exec ${WP_CONTAINER_NAME} wp plugin activate $PLUGIN --allow-root
done

# Custom user scripts
if [ -f "$PLUGIN_PATH/project.sh" ]; then
    echo "Starting project scripts..."
    $PLUGIN_PATH/project.sh
fi