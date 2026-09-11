FROM php:7.3-apache

RUN a2enmod rewrite

RUN cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

RUN sed -i 's|deb.debian.org/debian-security|archive.debian.org/debian-security|g; s|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list \
    && sed -i '/bullseye-updates/d' /etc/apt/sources.list \
    && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

RUN apt-get update
RUN apt-get -y install locales libxml2-dev
RUN sed -i '/en_GB.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
RUN sed -i '/sv_SE.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

ENV LANG=en_GB.UTF-8
ENV LANGUAGE=en_GB:en
ENV LC_ALL=en_GB.UTF-8

RUN docker-php-ext-install mysqli pdo pdo_mysql soap

RUN sed -i -e 's/^display_errors\s*=\s*On/display_errors = Off/g' $PHP_INI_DIR/php.ini

COPY ./src/ /var/www/html/