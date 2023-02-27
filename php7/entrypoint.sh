#!/bin/bash

# Umask should be set to 002 or group write will be disabled
# Quite a few installs run into an issue where UMASK 022 should be 002 so its closer to 0775
# https://hub.docker.com/r/nubs/composer-build/~/dockerfile/
umask 002
set -e

install_xdebug() {
    # xdebug for 7.4 no longer available via PECL etc
    cd /tmp && curl https://xdebug.org/files/xdebug-2.9.8.tgz| tar xvzf -
    cd xdebug-2.9.8
    phpize && ./configure
    make clean && make && make install
    docker-php-ext-enable xdebug
    cd $OLDPWD
}

# Enable xdebug if the ENABLE_XDEBUG environment variable is set
# We only want xdebug in specific circumstances so it's better to opt-in when we need it
if [ -n "$ENABLE_XDEBUG" ]; then
    install_xdebug
    touch /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_autostart=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_connect_back=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

# Enable xdebug if the ENABLE_XDEBUG environment variable is set
# We only want xdebug in specific circumstances so it's better to opt-in when we need it
if [ -n "$ENABLE_XDEBUG_FORCEHOST" ]; then

    install_xdebug
    touch /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_autostart=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i "1 a xdebug.remote_host=$ENABLE_XDEBUG_FORCEHOST" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

# Run php-fpm
php-fpm
