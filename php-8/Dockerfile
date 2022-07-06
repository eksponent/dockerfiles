ARG ARCH=${ARCH}

FROM php:8.1-fpm

RUN pecl install mysql redis

# Install modules
RUN apt-get update && apt-get install -y  --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpq-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libonig-dev \
    apt-utils \
    mariadb-client \
    zlib1g-dev \
    git \
    imagemagick \
    libwebp-dev \
    unzip \
    mailutils \
    msmtp \
    libzip-dev

RUN docker-php-ext-install pdo_mysql mbstring opcache zip curl \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ --with-webp=/usr/include/  \
    && docker-php-ext-install gd \
    && docker-php-ext-install exif \
    && docker-php-ext-install soap


# Install required RabbitMQ modules
RUN docker-php-ext-install -j$(nproc) bcmath

# imagemagick as PHP extension
RUN apt-get install -y libmagickwand-dev --no-install-recommends \
 && pecl install imagick \
 && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

 # Install ldap
RUN \
    debArch="$(dpkg-architecture --query DEB_BUILD_MULTIARCH)"; \
    apt-get update && \
    apt-get install libldap2-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure ldap --with-libdir=lib/$debArch/ && \
    docker-php-ext-install ldap


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Copenhagen /etc/localtime
RUN "date"

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install pdo pdo_mysql
RUN echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

