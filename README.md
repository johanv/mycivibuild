# MyCiviBuild

Me, just trying to get a development environment for upstream
CiviCRM development on Drupal.

## How to run

* disable any local webserver on port 80
* run `sudo docker-compose up`
* run `sudo docker-compose run buildkit amp config`
    * use .my.cnf for mysql configuration
    * use world writeable for permissions (it is dev, it won't hurt)
    * choose none everytime something is asked about web server configuration
* run `sudo docker-compose run buildkit civibuild create dmaster --force`

You can now access your civicrm instance at http://localhost

## Drush

Create an alias for drush:

    alias drush='sudo docker-compose run buildkit drush --root=/opt/buildkit/build/dmaster'

Now you can create a one time login link for user 1:



## Remarks

If the buildkit image does not build, because some debian package does not
download, try connecting via another ISP.
