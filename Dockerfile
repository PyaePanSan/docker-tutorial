# This tells Docker to download and use the php:8.0-fpm image.
FROM php:8.0-fpm

# run apt-get to install the dependencies and extensions required by Laravel
RUN apt-get update && apt-get install -y libmcrypt-dev \
    openssl \
    libonig-dev \
    software-properties-common \
    npm
RUN docker-php-ext-install pdo mbstring

# install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


WORKDIR /var/www
COPY . /var/www

RUN composer install
RUN npm install npm@latest -g && \
    npm install n -g && \
    n latest
RUN npm run dev

CMD php artisan serve --host=0.0.0.0 --port=8000
EXPOSE 8000