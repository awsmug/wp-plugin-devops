#!/bin/bash

if [ ! -d $DEVOPS_PATH ]; then
    mkdir -p $DEVOPS_PATH
fi

mkdir -p $CONF_PATH

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
    cp ${DIST_PATH}/plugin.php ${PLUGIN_PATH}/plugin.php
    echo "plugin.php added."
fi

TEST_PATH=${PLUGIN_PATH}/tests

read -p "Create test files for PHPUnit? (y/n) " add_test_files

if [ "y" = $add_test_files ]; then
    mkdir -p ${TEST_PATH}
    cp -R ${CONF_DIST_PATH}/phpunit.xml.dist ${PLUGIN_PATH}/conf/phpunit.xml
    cp -R ${DIST_PATH}/tests/phpunit/. ${TEST_PATH}/phpunit/
    echo "phpunit.xml PHPUnit files added."
fi

read -p "Create test files for behat? (y/n) " add_test_files

if [ "y" = $add_test_files ]; then
    mkdir -p ${TEST_PATH}
    cp ${CONF_DIST_PATH}/behat.yml.dist ${CONF_PATH}/behat.yml
    cp -R ${DIST_PATH}/tests/behat/ ${TEST_PATH}/behat/
    echo "behat.yml and test files added."
fi

read -p "Create a travis file? (y/n) " add_travis_files

if [ "y" = $add_travis_files ]; then
    cp ${CONF_DIST_PATH}/.travis.yml.dist ${PLUGIN_PATH}/.travis.yml
    echo "travis.yml added."
fi

read -p "Create a docker compose? (y/n) " add_docker_compose

if [ "y" = $add_docker_compose ]; then
    cp ${CONF_DIST_PATH}/docker-compose.yml.dist ${PLUGIN_PATH}/docker-compose.yml

    echo "docker-compose.yml added."
fi

read -p "Please enter a hostname: " add_hostname

if [ -z "$add_hostname" ]; then
    echo "No host entered."
    exit 1
fi

cp ${CONF_DIST_PATH}/default.conf.dist ${CONF_PATH}/default.conf

sed -i -e 's/wordpress.dev/'${add_hostname}'/' ${PLUGIN_PATH}/docker-compose.yml
sed -i -e 's/wordpress.dev/'${add_hostname}'/' ${CONF_PATH}/default.conf

rm ${CONF_PATH}/default.conf-e
rm ${PLUGIN_PATH}/docker-compose.yml-e