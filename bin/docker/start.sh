#!/bin/sh

echo "Starting webserver..."

docker-compose -f ${DOCKER_COMPOSE_FILE} up -d

echo "Initializing project..." >&2

echo "Waiting for Database..."
${BIN_PATH}/waitfor localhost 3306 # Does not take effect right now

echo "Database ready."
sleep 90

docker exec ${WP_CONTAINER_NAME} wp plugin update --all --path=/var/www/html
docker exec ${WP_CONTAINER_NAME} wp theme update --all --path=/var/www/html

REMOTE_PLUGIN_PATH=${PLUGIN_PATH}/wordpress/wp-content/plugins/
docker exec ${WP_CONTAINER_NAME} mkdir -p ${REMOTE_PLUGIN_PATH}
${BIN_PATH}/sync.sh
docker exec ${WP_CONTAINER_NAME} wp plugin activate ${PLUGIN_SLUG} --path=/var/www/html

# Custom user scripts
if [ -f "${PLUGIN_PATH}/project.sh" ]; then
    echo "Starting project scripts..."
    ${PLUGIN_PATH}/project.sh
fi

echo "Finished starting webserver!"