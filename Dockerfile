FROM php:7.3-apache

RUN a2enmod rewrite

RUN cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

# Peka om till Debian Archive för att klara EOL för PHP 7.3 samt installera paket
RUN echo "deb http://archive.debian.org/debian/ buster main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian/ buster-updates main" >> /etc/apt/sources.list && \
    apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get -y --allow-downgrades install libxml2=2.9.4+dfsg1-7+deb10u4 libxml2-dev=2.9.4+dfsg1-7+deb10u4

ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN docker-php-ext-install mysqli pdo pdo_mysql soap

RUN sed -i -e 's/^display_errors\s*=\s*On/display_errors = Off/g' $PHP_INI_DIR/php.ini

COPY ./src/ /var/www/html/