# WordPress Plugin Devops

## Setting everything up

### Requirements

For this library [Composer](https://getcomposer.org/download/) and [Docker](https://www.docker.com/) is required. Please install before starting.

### Install

Add WP Plugin Devops functionality by using Composer. 

```bash
composer require awsmug/wp-plugin-devops:dev-master
```

Install the environment by setting up config files for git, composer, phpunit and so on.

```bash
vendor/bin/wpdevops install
```

Start the local server.

```bash
vendor/bin/wpdevops start
```

Stop the local server.

```bash
vendor/bin/wpdevops stop
```

After the changes were made, sync your data to the docker container.

```bash
vendor/bin/wpdevops sync
```

Clean up all automatic produced scripts.

```bash
vendor/bin/wpdevops clean
```

## Local Development

### Docker container for development

The docker on which the environment is based contains.

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