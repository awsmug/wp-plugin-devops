# WordPress Plugin Devops

## Setting everything up

### Requirements

For this library [Composer](https://getcomposer.org/download/) and [Docker](https://www.docker.com/) is required. Please install before starting.

### Install

Add WP Plugin Devops functionality by using Composer. 

```bash
composer require awsmug/wp-plugin-devops:dev-master
```

Start the local server.

```bash
vendor/bin/webserver start
```

Stop the local server.

```bash
vendor/bin/webserver stop
```

Clean up all local produced scripts.

```bash
vendor/bin/webserver clean
```

## Local Development

### Docker container for development

Starting docker containers manual:

```bash
docker-compose up
```

The docker environment contains.

* Nginx webserver
* WordPress
* WP-CLI
* PHP
* phpMyAdmin
* phpUnit
* Behat

## Testing

### Travis

You can connect your github account with travis and all your tests will be executed automatically on pushing your code to github.

#### phpUnit

Put all your tests to the directory *'tests/phpunit'*.

### Behat
Put all your .feature files to the directory *'tests/behat'* and all your FeatureContext class files to the directory *'tests/behat'*.