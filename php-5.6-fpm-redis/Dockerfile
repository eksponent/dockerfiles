FROM php:5.6-fpm
# Install modules
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libpq-dev \
        apt-utils \
        git \
        drush \
        mysql-client \
        zlib1g-dev \
     # General packages that should already be included with the right image
     && docker-php-ext-install zip  \
     && docker-php-ext-install pdo_mysql mbstring opcache \
     && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
     && docker-php-ext-install gd \
     # redis
     && curl -L https://pecl.php.net/get/redis-2.2.7.tgz >> /usr/src/php/ext/redis.tgz \
     && tar -xf /usr/src/php/ext/redis.tgz -C /usr/src/php/ext/ \
     && rm /usr/src/php/ext/redis.tgz \
     && docker-php-ext-install redis-2.2.7

# Quite a few installs run into an issue where UMASK 022 should be 002 so its closer to 0775
# https://hub.docker.com/r/nubs/composer-build/~/dockerfile/
ADD umask.sh /usr/local/bin/umask.sh
RUN chmod +x /usr/local/bin/umask.sh

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

ENTRYPOINT ["/usr/local/bin/umask.sh"]
CMD ["php-fpm"]