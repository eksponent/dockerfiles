FROM php:5.6-cli
MAINTAINER Eksponent <info@eksponent.com>

VOLUME /var/www/html
WORKDIR /var/www/html

RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev unzip patch git sudo mysql-client imagemagick \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd mbstring pdo pdo_mysql zip \
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && echo "export PATH=~/.composer/vendor/bin:\$PATH" >> ~/.bash_profile \
  && rm -rf /var/lib/apt/lists/*



COPY php.ini php.ini /usr/local/etc/php/conf.d/


RUN apt-get update && apt-get install -y  --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libpq-dev \
    apt-utils \
    mysql-client \
    zlib1g-dev \
    imagemagick \
    unzip

RUN docker-php-ext-install pdo_mysql mbstring opcache \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# imagemagick as PHP extension
RUN apt-get install -y libmagickwand-6.q16-dev --no-install-recommends \
 && ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin \
 && pecl install imagick \
 && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

# LDAP (used by RUC)
RUN apt-get install libldap2-dev -y && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
    docker-php-ext-install ldap 


RUN curl -L https://pecl.php.net/get/redis-2.2.7.tgz > /tmp/redis.tgz \
    && mkdir -p /usr/src/php/ext \
    && tar -xvf /tmp/redis.tgz -C /usr/src/php/ext \
    && rm /tmp/redis.tgz \
    && docker-php-ext-install redis-2.2.7




# Include memcache for installs that require it
RUN pecl install memcache && docker-php-ext-enable memcache


ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


RUN mkdir /drush \
  && chmod -R +rx /drush \
  && cd /drush && composer require drush/drush:8.* \
  && ln -s /drush/vendor/bin/drush /usr/local/bin/drush \
  && drush core-status -y \

CMD ["drush", "core-cli"]

