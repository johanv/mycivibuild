# MyCiviBuild

Me, just trying to get a development environment for upstream
CiviCRM development on Drupal.

This is yet another docker image for civirm-buildkit.
progressivetech has a similar project:
[docker-civicrm-buildkit](https://github.com/progressivetech/docker-civicrm-buildkit).
It might be better than mine, I did not look at this.

Disclaimer: I am a docker noob. But I welcome feedback and pull
requests :-)

## How to run

Disable anly local webserver running at port 80, and issue these commands:

    # create directories for local build and local extensions
    mkdir -p build/html
    mkdir extensions
    sudo docker-compose up -d
    sudo docker-compose exec web chown -R civi:www-data /var/www/html
    sudo docker-compose exec web chmod -R ug+rwX /var/www/html/sites/default/files
    sudo docker-compose exec --user civi web civibuild create dmaster --web-root /var/www/html --url http://localhost

(add `--force` to the civibuild command if it does not work.)

You can now access your civicrm instance at http://localhost. The source files are
available under the 'build' directory.

## Drush

Create an alias for drush:

    alias drush='sudo docker-compose exec --user civi web drush --root=/var/www/html'

Now you can create a one time login link for user 1:

    drush uli --uri=http://localhost
    
## Remarks

If the buildkit image does not build, because some debian package does not
download, try connecting via another ISP.
