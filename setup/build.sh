#!/bin/bash

mkdir -p /var/www/html 2> /dev/null

# setup civicrm with civibuild

# add --force to the command below if civibuild does not work.
su -c "/opt/buildkit/bin/civibuild create dmaster --web-root /var/www/html --url http://localhost" civi
chown -R civi:www-data /var/www/html
chmod -R ug+rwX /var/www/html/sites/default/files
su -c "/opt/buildkit/bin/drush --root=/var/www/html vset clean_url 0" civi

# custom extensions directory

mkdir -p /opt/ext/cache 2> /dev/null
touch /opt/ext/cache/timestamp.txt
touch /opt/ext/cache/extensions.json

chown -R civi:www-data /opt/ext
chmod -R ug+rwX /opt/ext

sed -i 's. //  global $civicrm_setting;.global $civicrm_setting;.' /var/www/html/sites/default/civicrm.settings.php
sed -i 's_ // \(.*\)/path/to/extensions-dir\(.*\)_\1/opt/ext\2_' /var/www/html/sites/default/civicrm.settings.php

# provide a uli

su -c "/opt/buildkit/bin/drush --root=/var/www/html uli --uri=http://localhost" civi


