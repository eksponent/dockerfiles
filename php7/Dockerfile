FROM php:7.1-fpm

RUN pecl install mysql redis

# Install modules
RUN apt-get update && apt-get install -y  --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libpq-dev \
    apt-utils \
    mysql-client \
    zlib1g-dev \
    git \
    imagemagick \
    unzip \
    mailutils \
    ssmtp

RUN docker-php-ext-install pdo_mysql mbstring opcache \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# imagemagick as PHP extension
RUN apt-get install -y libmagickwand-6.q16-dev --no-install-recommends \
 && pecl install imagick \
 && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Prague /etc/localtime
RUN "date"

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install pdo pdo_mysql
RUN echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini 

