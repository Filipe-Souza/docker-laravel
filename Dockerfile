FROM php:7.2-fpm

RUN apt-get update -y
RUN apt-get install -y libmcrypt-dev curl wget git gcc make autoconf pkg-config mysql-client nano --no-install-recommends

RUN apt-get install zip unzip -y
RUN apt-get install libmagickwand-dev -y
RUN apt-get install libzmq3-dev libevent-dev libssl-dev -y
RUN pecl install imagick && docker-php-ext-enable imagick
RUN docker-php-ext-install pdo_mysql pdo mbstring zip xml json bcmath gd exif

COPY composer_install.sh /tmp/install.sh

RUN chmod a+x /tmp/install.sh && bash /install.sh && mv composer.phar /usr/local/bin/composer

RUN usermod -u 1000 www-data && usermod -aG www-data root

RUN mkdir -p /var/www/.composer && chmod 775 -R /var/www/.composer/

USER www-data