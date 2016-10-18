FROM php:apache
MAINTAINER johan.vervloet@chiro.be

RUN apt-get update && apt-get install -yq mysql-client libxml2-dev libmcrypt-dev libpng12-dev
RUN docker-php-ext-install xml mcrypt gd mysqli pdo pdo_mysql mbstring

RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini 

RUN echo "[PHP] \n\
memory_limit = 256M \n\
max_execution_time = 120 \n\
EOF" > /usr/local/etc/php/php.ini