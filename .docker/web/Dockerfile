FROM php:apache
MAINTAINER johan.vervloet@chiro.be

# hack because otherwise I cannot build this from home. Thank you telenet :-(
# see https://github.com/rgeissert/http-redirector/issues/74#issuecomment-241682578
RUN sed -i "s/httpredir.debian.org/`curl -s -D - http://httpredir.debian.org/demo/debian/ | awk '/^Link:/ { print $2 }' | sed -e 's@<http://\(.*\)/debian/>;@\1@g'`/" /etc/apt/sources.list

# install stuff for webserver
RUN apt-get update && apt-get install -yq mysql-client libxml2-dev libmcrypt-dev libpng12-dev
RUN docker-php-ext-install xml mcrypt gd mysqli pdo pdo_mysql mbstring

# enable xdebug, thanks https://gist.github.com/chadrien/c90927ec2d160ffea9c4
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

# more resources for php
RUN echo "[PHP] \n\
memory_limit = 256M \n\
max_execution_time = 120 \n\
" > /usr/local/etc/php/php.ini

# buildkit stuff. I'd prefer to do this in another container, but I have the impression that if you build your
# CiviCRM instance with buildkit, the web site needs access to buildkit as well.

RUN apt-get update \
  && apt-get install -yq npm git unzip zip \
  && ln -s /usr/bin/nodejs /usr/local/bin/node \
  && docker-php-ext-install mysqli \
  && git clone https://github.com/civicrm/civicrm-buildkit.git /opt/buildkit \
  && cd /opt/buildkit && ./bin/civi-download-tools

RUN groupadd civi \
  && useradd -g civi -m civi \
  && chown -R civi /opt/buildkit \
  && chmod -R ug+rwX /opt/buildkit \
  && chown -R civi:www-data /var/www \
  && chmod -R ug+rwX /var/www

RUN echo "[client] \n\
user=root \n\
password=blablablaroot \n\
host=db " > /home/civi/.my.cnf

RUN su -c "/opt/buildkit/bin/amp config:set --db_type=mysql_mycnf --hosts_type=none --perm_type=worldWritable" civi

ENV PATH /opt/buildkit/bin:$PATH