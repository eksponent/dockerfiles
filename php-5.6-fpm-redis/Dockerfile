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

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

CMD ["php-fpm"]