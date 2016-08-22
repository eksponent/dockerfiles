FROM php:5.6-fpm

# Install modules
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libpq-dev \
    apt-utils \
    mysql-client \
    zlib1g-dev \
    imagemagick

RUN docker-php-ext-install pdo_mysql mbstring opcache \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd



RUN curl -L https://pecl.php.net/get/redis-2.2.7.tgz > /tmp/redis.tgz \
    && mkdir -p /usr/src/php/ext \
    && tar -xvf /tmp/redis.tgz -C /usr/src/php/ext \
    && rm /tmp/redis.tgz \
    && docker-php-ext-install redis-2.2.7

RUN pecl install memcache && docker-php-ext-enable memcache

ADD local.ini /usr/local/etc/php/conf.d/local.ini
ADD fake-sendmail.sh /usr/local/bin/fake-sendmail.sh

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
