#!/bin/sh

echo "Starting development environment..."

docker-compose -f $DOCKER_COMPOSE_FILE up -d

echo "Initializing project..." >&2

echo "Container: $WP_CONTAINER_NAME"

echo "Waiting for Server..."
sleep 20

REMOTE_PLUGIN_PATH=${PLUGIN_PATH}/wordpress/wp-content/plugins/
docker exec ${WP_CONTAINER_NAME} mkdir -p ${REMOTE_PLUGIN_PATH}
rsync -rv --exclude-from=${BIN_PATH}/exclude-plugin-files.txt ${PLUGIN_PATH} ${REMOTE_PLUGIN_PATH}
docker exec ${WP_CONTAINER_NAME} wp plugin activate ${PLUGIN_SLUG} --path=/var/www/html

# Custom user scripts
if [ -f "${PLUGIN_PATH}/project.sh" ]; then
    echo "Starting project scripts..."
    ${PLUGIN_PATH}/project.sh
fi

echo "Finished starting webserver!"