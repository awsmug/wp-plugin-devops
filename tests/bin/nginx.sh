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

mkdir -p "$NGINX_DIR/nginx/sites-enabled"

# Configure the PHP handler.
PHP_FPM_BIN="$HOME/.phpenv/versions/$PHP_VERSION/sbin/php-fpm"
PHP_FPM_CONF="$NGINX_DIR/nginx/php-fpm.conf"

# Start php-fpm.
tpl "$CURRENT_DIR/tests/bin/php-fpm.tpl.conf" "$PHP_FPM_CONF"
"$PHP_FPM_BIN" --fpm-config "$PHP_FPM_CONF"

# Build the default nginx config files.
tpl "$CURRENT_DIR/tests/bin/nginx.tpl.conf" "$NGINX_DIR/nginx/nginx.conf"
tpl "$CURRENT_DIR/tests/bin/fastcgi.tpl.conf" "$NGINX_DIR/nginx/fastcgi.conf"
tpl "$CURRENT_DIR/tests/bin/default-site.tpl.conf" "$NGINX_DIR/nginx/sites-enabled/default-site.conf"

# Start nginx.
nginx -c "$NGINX_DIR/nginx/nginx.conf"
