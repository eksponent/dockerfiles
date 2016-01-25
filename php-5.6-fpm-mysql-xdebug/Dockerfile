FROM php:5.6-fpm

# Install modules
RUN apt-get update && apt-get install -y \
        mysql-client

RUN docker-php-ext-install pdo_mysql mbstring opcache

CMD ["php-fpm"]