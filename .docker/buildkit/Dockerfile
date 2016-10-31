FROM php:cli
MAINTAINER johan.vervloet@chiro.be

RUN apt-get update \
  && apt-get install -yq mysql-client libxml2-dev libmcrypt-dev libpng12-dev npm git unzip zip \
  && ln -s /usr/bin/nodejs /usr/local/bin/node \
  &&  docker-php-ext-install xml mcrypt gd pdo pdo_mysql mysqli mbstring \
  && git clone https://github.com/civicrm/civicrm-buildkit.git /opt/buildkit \
  && cd /opt/buildkit && ./bin/civi-download-tools

RUN groupadd civi \
  && useradd -g civi -m civi \
  && chown -R civi:www-data /opt/buildkit \
  && chmod -R ug+rwX /opt/buildkit

RUN echo "[client] \n\
user=root \n\
password=blablablaroot \n\
host=db " > /home/civi/.my.cnf

RUN su -c "/opt/buildkit/bin/amp config:set --db_type=mysql_mycnf --hosts_type=none --perm_type=worldWritable" civi

ENV PATH /opt/buildkit/bin:$PATH

