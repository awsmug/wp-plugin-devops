#!/bin/bash

if [ ! -d $DEVOPS_PATH ]; then
    mkdir -p $DEVOPS_PATH
fi

# Setting up files
if [ -d vendor/awsmug/wp-plugin-devops ]; then
    # As Composer depency
    export NGINX_CONF_REL=vendor/awsmug/wp-plugin-devops/bin/docker/nginx/default.conf.dist
    export NGINX_CONF=${PLUGIN_PATH}/vendor/awsmug/wp-plugin-devops/bin/docker/nginx/default.conf.dist
    export NGINX_CONF_DEST_REL=devops/conf/default.conf
    export NGINX_CONF_DEST=${PLUGIN_PATH}/${NGINX_CONF_DEST_REL}
else
    # Direct variant
    export NGINX_CONF=${PLUGIN_PATH}/bin/docker/nginx/default.conf.dist
    export NGINX_CONF_DEST_REL=devops/conf/default.conf
    export NGINX_CONF_DEST=${PLUGIN_PATH}/${NGINX_CONF_DEST_REL}
fi

function add_to_gitignore {
    echo "###" >> $1
    echo "# Automatinc added files from WP Plugin Devops" >> $1
    echo "###" >> $1
    echo "composer.lock" >> $1
    echo "test" >> $1
    echo "webserver" >> $1
    echo "vendor" >> $1
    echo "wordpress" >> $1
}

GITIGNORE_FILE="${PLUGIN_PATH}/.gitignore"

if [ -e $GITIGNORE_FILE ]; then
    read -p ".gitignore file exists would you like to add not necessary files to it (y/n): " add_gitignore

    if [ "y" = $add_gitignore ]; then
        add_to_gitignore $GITIGNORE_FILE
    fi
else
    read -p ".gitignore file not found. Would you like to create one and add not necessary files to it (y/n): " add_gitignore

    if [ "y" = $add_gitignore ]; then
        add_to_gitignore $GITIGNORE_FILE
    fi
fi

read -p "Create a main plugin file? (y/n) " add_plugin_file

if [ "y" = $add_plugin_file ]; then
    cp ${DEVOPS_PATH}/plugin.php ${PLUGIN_PATH}/plugin.php
    echo "plugin.php added."
fi

TEST_PATH=${PLUGIN_PATH}/tests

read -p "Create test files for PHPUnit? (y/n) " add_test_files

if [ "y" = $add_test_files ]; then
    mkdir -p $TEST_PATH
    cp -R ${DEVOPS_PATH}/phpunit.xml ${PLUGIN_PATH}/phpunit.xml
    cp -R ${DEVOPS_PATH}/tests/phpunit/. $TEST_PATH/phpunit/
    echo "PHPUnit est files added."
fi

read -p "Create test files for behat? (y/n) " add_test_files

if [ "y" = $add_test_files ]; then
    mkdir -p $TEST_PATH
    cp -R ${DEVOPS_PATH}/behat.yml ${PLUGIN_PATH}/behat.yml
    cp -R ${DEVOPS_PATH}/tests/behat/. $TEST_PATH/behat/
    echo "behat test files added."
fi

TRAVIS_FILE=${PLUGIN_PATH}/.travis.yml

read -p "Create a travis file? (y/n) " add_travis_files

if [ "y" = $add_travis_files ]; then
    cp -R ${DEVOPS_PATH}/.travis.yml ${PLUGIN_PATH}/.travis.yml
    echo "Test files added."
fi

read -p "Create a docker compose? (y/n) " add_docker_compose_file

if [ "y" = $add_docker_compose_file ]; then
    search='bin/docker/nginx/default.conf'
    replace=${NGINX_CONF_DEST_REL}

    cp ${DOCKER_COMPOSE_FILE} ${DOCKER_COMPOSE_DEST}

    sed -i -e "s/${search//\//\\/}/${replace//\//\\/}/g" "${DOCKER_COMPOSE_DEST}"
    rm ${DOCKER_COMPOSE_DEST}-e
    echo "Compose files added."
fi

read -p "Please enter a hostname: " add_hostname

if [ -z "$add_hostname" ]; then
    echo "No host entered."
    exit 1
fi

cp ${NGINX_CONF} ${NGINX_CONF_DEST}

sed -i -e 's/wordpress.dev/'${add_hostname}'/' ${DOCKER_COMPOSE_DEST}
sed -i -e 's/wordpress.dev/'${add_hostname}'/' ${NGINX_CONF_DEST}

rm ${NGINX_CONF_DEST}-e
rm ${DOCKER_COMPOSE_DEST}-e