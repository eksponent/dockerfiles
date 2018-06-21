#!/bin/bash

# Umask should be set to 002 or group write will be disabled
# Quite a few installs run into an issue where UMASK 022 should be 002 so its closer to 0775
# https://hub.docker.com/r/nubs/composer-build/~/dockerfile/
umask 002

# Enable xdebug if the ENABLE_XDEBUG environment variable is set
# We only want xdebug in specific circumstances so it's better to opt-in when we need it
if [ -n "$ENABLE_XDEBUG" ]; then
    # Install and configure Xdebug, RUN is not used in entrypoint scripts
    pecl install xdebug-2.5.5 \
        && docker-php-ext-enable xdebug \
        && touch /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
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
    # Install and configure Xdebug, RUN is not used in entrypoint scripts
    pecl install xdebug \
        && docker-php-ext-enable xdebug \
        && touch /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        && sed -i '1 a xdebug.remote_autostart=true' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        && sed -i '1 a xdebug.remote_mode=req' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        && sed -i '1 a xdebug.remote_handler=dbgp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        && sed -i '1 a xdebug.remote_port=9000' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        && sed -i "1 a xdebug.remote_host=$ENABLE_XDEBUG_FORCEHOST" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        && sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi


if [ -n "$ENABLE_MEMCACHE" ]; then
	
	RUN apt-get update \
  	&& apt-get install -y php5-memcached \
  	&& apt-get install -y build-essential memcached php-pear
fi

if [ -n "$ENABLE_XDEBUG_PROFILE" ]; then
	sed -i '1 a xdebug.profiler_enable = 1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
	sed -i '1 a xdebug.profiler_output_dir = /tmp' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi


if [ -d "/mailspool" ]
then
  chown www-data.www-data /mailspool
fi

# Run php-fpm catch_workers_output will help to push the logs back up the docker stderr pipe.
php-fpm -d catch_workers_output=yes
