#!/bin/bash
# From https://github.com/tburry/travis-nginx-test

# Exit if anything fails AND echo each command before executing
# http://www.peterbe.com/plog/set-ex
set -ex

USER=$(whoami)
PHP_VERSION=$(phpenv version-name)
ROOT=$WP_DIR
PORT=9000
SERVER=wordpress.dev

function tpl {
  sed \
    -e "s|{DIR}|$NGINX_DIR|g" \
    -e "s|{USER}|$USER|g" \
    -e "s|{PHP_VERSION}|$PHP_VERSION|g" \
    -e "s|{ROOT}|$ROOT|g" \
    -e "s|{PORT}|$PORT|g" \
    -e "s|{SERVER}|$SERVER|g" \
    < $1 > $2
}

mkdir -p "$NGINX_DIR/sites-enabled"

# Configure the PHP handler.
PHP_FPM_CONF="$NGINX_DIR/php-fpm.conf"

# Start php-fpm.
tpl "$BIN_DIR/travis/conf/php-fpm.tpl.conf" "$PHP_FPM_CONF"
"$PHP_FPM_BIN" --allow-to-run-as-root --fpm-config "$PHP_FPM_CONF"

# Build the default nginx config files.
tpl "$BIN_DIR/travis/conf/nginx.tpl.conf" "$NGINX_DIR/nginx.conf"
tpl "$BIN_DIR/travis/conf/fastcgi.tpl.conf" "$NGINX_DIR/fastcgi.conf"
tpl "$BIN_DIR/travis/conf/default-site.tpl.conf" "$NGINX_DIR/sites-enabled/default-site.conf"

ps aux
# Start nginx.
nginx -V -t -c "$NGINX_DIR/nginx.conf" -s reload

ps aux