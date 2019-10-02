FROM php:5.6-fpm
# Install modules

RUN mkdir -p /usr/src/php/ext

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libpq-dev \
        apt-utils \
        git \
        mysql-client \
        zlib1g-dev \
        libxml2-dev \
     # General packages that should already be included with the right image
     && docker-php-ext-install zip  \
     && docker-php-ext-install pdo_mysql mbstring opcache \
     && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
     && docker-php-ext-install gd \
     && docker-php-ext-install soap 

RUN curl -L https://pecl.php.net/get/redis-2.2.7.tgz > /tmp/redis.tgz \
    && tar -xvf /tmp/redis.tgz -C /usr/src/php/ext \
    && rm /tmp/redis.tgz \
    && docker-php-ext-install redis-2.2.7

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Install Drush.
RUN composer global require drush/drush:7.*
ADD profile-extras.sh /etc/profile.d/profile-extras.sh

# Symlink in all the new stuff to the default path, to be even more sure it's discovered.
RUN ln -s /root/.composer/vendor/bin/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]