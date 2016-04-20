FROM php:5.6-cli
MAINTAINER Eksponent <info@eksponent.com>

VOLUME /var/www/html
WORKDIR /var/www/html

RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev unzip patch git \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd mbstring pdo pdo_mysql zip \
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && echo "export PATH=~/.composer/vendor/bin:\$PATH" >> ~/.bash_profile \

COPY php.ini php.ini /usr/local/etc/php/conf.d/

RUN apt-get install -y mysql-client \
  && composer global require drush/drush:6.* \
  && ln -s ~/.composer/vendor/bin/drush /usr/local/bin/drush \
  && drush core-status -y \
  && rm -rf /var/lib/apt/lists/*

CMD ["drush", "core-cli"]