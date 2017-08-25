# WordPress Plugin Devops

## Setting everything up

Clone this repository. And put or merge all files to your WordPress plugin.

```bash
git clone git@github.com:awsmug/wp-plugin-devops.git
```

Start the local server.

```bash
bin/webserver start
```

Stop the local server.

```bash
bin/webserver stop
```

Clean up all local produced scripts.

```bash
bin/webserver clean
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