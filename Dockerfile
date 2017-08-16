FROM alpine
MAINTAINER Awesome UG<support@awesome.ug>

RUN apk update \
    && apk add --no-cache \
    bash \
    less \
    vim \
    nginx \
    ca-certificates \
    php7-fpm \
    php7-json \
    php7-zlib \
    php7-xml \
    php7-pdo \
    php7-phar \
    php7-openssl \
    php7-pdo_mysql \
    php7-mysqli \
    php7-session \
    php7-gd \
    php7-iconv \
    php7-mcrypt \
    php7-curl \
    php7-opcache \
    php7-ctype \
    php7-apcu \
    php7-intl \
    php7-bcmath \
    php7-mbstring \
    php7-dom \
    php7-xmlreader \
    mysql-client \
    openssh-client \
    git \
    curl \
    rsync \
    musl \
    && apk --update --no-cache add tar

RUN rm -rf /var/cache/apk/*

ENV TERM="xterm" \
    PHP_VERSION="7.0" \
    PHP_FPM_BIN="/usr/sbin/php-fpm7" \
    CURRENT_DIR=$(pwd) \
    PROJECT_DIR=$(pwd) \
    BIN_DIR=$PROJECT_DIR/bin/ \
    VENDOR_BIN_DIR=$PROJECT_DIR/vendor/bin/ \
    PATH=$PATH:$VENDOR_BIN_DIR:$BIN_DIR:/usr/bin \
    NGINX_DIR=/etc \
    DB_HOST="localhost" \
    DB_NAME="wordpress" \
    DB_USER="root"\
    DB_PASS="root"\
    WP_DIR="/tmp/wordpress/" \
    PLUGIN_DIR=$PROJECT_DIR

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp && chown nginx:nginx /usr/bin/wp

RUN mkdir -p /run/nginx

ADD bin/init-nginx.sh $BIN_DIR/init-nginx.sh
ADD bin/init-selenium.sh $BIN_DIR/init-selenium.sh
ADD bin/init-selenium.sh $BIN_DIR/nit-wordpress.sh

ADD bin/default-site.tpl.conf $BIN_DIR/default-site.tpl.conf
ADD bin/fastcgi.tpl.conf $BIN_DIR/fastcgi.tpl.conf
ADD bin/nginx.tpl.conf $BIN_DIR/nginx.tpl.conf
ADD bin/php-fpm.tpl.conf $BIN_DIR/php-fpm.tpl.conf

RUN $BIN_DIR/init-nginx.sh
RUN $BIN_DIR/init-selenium.sh
RUN $BIN_DIR/init-wordpress.sh

EXPOSE 80
# ADD files/nginx.conf /etc/nginx/
# ADD files/php-fpm.conf /etc/php7/