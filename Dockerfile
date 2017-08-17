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
    mysql \
    mysql-client \
    pwgen \
    openssh-client \
    git \
    curl \
    rsync \
    musl \
    openjdk7-jre \
    && apk --update --no-cache add tar


RUN apk --update add mysql mysql-client pwgen && rm -f /var/cache/apk/*

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
    WP_DIR="/tmp/wordpress" \
    PLUGIN_DIR=$PROJECT_DIR

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp && chown nginx:nginx /usr/bin/wp

RUN mkdir -p /run/nginx

ADD bin/* $BIN_DIR

RUN $BIN_DIR/init-nginx.sh
RUN $BIN_DIR/init-mysql.sh
RUN $BIN_DIR/init-selenium.sh
RUN $BIN_DIR/init-wordpress.sh $DB_NAME $DB_USER $DB_PASS $DB_HOST 4.8.1 $WP_DIR

EXPOSE 80
EXPOSE 3306
# ADD files/nginx.conf /etc/nginx/
# ADD files/php-fpm.conf /etc/php7/