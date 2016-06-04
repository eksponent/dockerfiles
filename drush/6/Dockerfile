FROM php:5.6-cli
MAINTAINER Eksponent <info@eksponent.com>

VOLUME /var/www/html
WORKDIR /var/www/html

RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev unzip patch git sudo mysql-client \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd mbstring pdo pdo_mysql zip \
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && echo "export PATH=~/.composer/vendor/bin:\$PATH" >> ~/.bash_profile \
  && rm -rf /var/lib/apt/lists/*

# Include memcache for installs that require it
RUN pecl install memcache && docker-php-ext-enable memcache


COPY php.ini php.ini /usr/local/etc/php/conf.d/

RUN mkdir /drush \
  && chmod -R +rx /drush \
  && cd /drush && composer require drush/drush:6.* \
  && ln -s /drush/vendor/bin/drush /usr/local/bin/drush \
  && drush core-status -y \


CMD ["drush", "core-cli"]
