FROM php:7.3-apache

RUN a2enmod rewrite

RUN cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

# Peka om till Debian Archive för att klara EOL för PHP 7.3 samt installera paket
RUN apt-get update && apt-get -y install wget binutils && \
    wget http://archive.debian.org/debian/pool/main/g/glibc/locales_2.28-10+deb10u1_all.deb && \
    dpkg-deb -x locales_2.28-10+deb10u1_all.deb / && \
    rm locales_2.28-10+deb10u1_all.deb && \
    localedef -i en_GB -f UTF-8 en_GB.UTF-8

ENV LANG=en_GB.UTF-8
ENV LANGUAGE=en_GB:en
ENV LC_ALL=en_GB.UTF-8

RUN docker-php-ext-install mysqli pdo pdo_mysql soap

RUN sed -i -e 's/^display_errors\s*=\s*On/display_errors = Off/g' $PHP_INI_DIR/php.ini

COPY ./src/ /var/www/html/