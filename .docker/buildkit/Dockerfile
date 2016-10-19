FROM php:cli
MAINTAINER johan.vervloet@chiro.be

RUN apt-get update \
  && apt-get install -yq mysql-client libxml2-dev libmcrypt-dev libpng12-dev npm git unzip zip \
  && ln -s /usr/bin/nodejs /usr/local/bin/node \
  &&  docker-php-ext-install xml mcrypt gd pdo pdo_mysql mysqli mbstring \
  && git clone https://github.com/civicrm/civicrm-buildkit.git /opt/buildkit \
  && cd /opt/buildkit && ./bin/civi-download-tools

RUN echo "[client] \n\
user=root \n\
password=blablablaroot \n\
host=db " > /root/.my.cnf

RUN apt-get install sudo

ENV PATH /opt/buildkit/bin:$PATH
