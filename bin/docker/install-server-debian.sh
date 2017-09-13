#!/bin/bash

HOST_NAME="testserver"
DOCKER_COMPOSE_VERSION="1.16.1"
MAIN_USER="wagesve"

##
# Installing base functionality on blank Debian Jessie OS
##
sudo echo "127.0.0.1 ${HOST_NAME}" > /etc/hosts

sudo gpg --keyserver keys.gnupg.net --recv-key 89DF5277
sudo gpg -a --export 89DF5277 | sudo apt-key add -

sudo echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.list
sudo apt-get update
sudo apt-get install -y git curl php7.0 php7.0-mbstring php7.0-curl php7.0-simplexml php7.0-zip apt-transport-https ca-certificates gnupg2 software-properties-common members
sudo apt-get remove apache2

sudo curl -o /usr/local/bin/composer https://getcomposer.org/composer.phar
sudo chmod +x /usr/local/bin/composer

sudo curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
sudo sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker docker-ce

sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo curl -o /usr/local/bin/composer https://getcomposer.org/composer.phar
sudo chmod +x /usr/local/bin/composer
sudo adduser ${MAIN_USER} docker
sudo adduser ${MAIN_USER} sudo

su ${MAIN_USER}

##
# Installing Test environment
##
mkdir -p srv/testing
cd srv/testing/

git clone https://github.com/awsmug/wp-plugin-devops.git
cd wp-plugin-devops/
composer update
bin/webserver start
