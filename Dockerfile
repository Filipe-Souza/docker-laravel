FROM php:7.2-fpm

RUN apt-get update -y
RUN apt-get install -y libmcrypt-dev curl wget git gcc make autoconf pkg-config mysql-client nano --no-install-recommends

RUN apt-get install zip unzip libmagickwand-dev libssl-dev libxslt-dev sudo -y
RUN pecl install imagick && docker-php-ext-enable imagick
RUN docker-php-ext-install pdo_mysql pdo mbstring zip xml json bcmath gd exif xsl

COPY composer_install.sh /tmp/install.sh

RUN chmod a+x /tmp/install.sh && bash /tmp/install.sh && mv composer.phar /usr/local/bin/composer

RUN usermod -u 1000 www-data && usermod -aG www-data root && adduser www-data sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /var/www/.composer && chmod 777 -R /var/www/.composer/

USER www-data