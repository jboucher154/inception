#!/bin/sh


# while ! mysql -u $MARIADB_USER -p $MARIADB_USER_PASSWORD -h mariadb $MARIADB_NAME; do
# 	sleep 5
# done
# change directory to where you want them first (may need to make one)


#setup with the wp-cli https://www.cloudways.com/blog/wp-cli-commands/
# make config
#skip check to be removed once database is connected and running

cd /var/www/html/
if [ ! -f "/var/www/html/.wordpress_installed" ]; then
	touch /var/www/html/.wordpress_installed
	wp core download --allow-root

	wp config create --dbname=$MARIADB_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_USER_PASSWORD --dbhost=mariadb --path=/var/www/html/ --force

	# install wordpress
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --path=/var/www/html/ --allow-root
	wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PASSWORD --path=/var/www/html/
	# install themes and plugins
	wp theme install pixl --activate
	wp plugin update --all
	wp option update siteurl "https://$DOMAIN_NAME"
	wp option update home "https://$DOMAIN_NAME"
else
	echo "wordpress already downloaded and setup"
fi

chown -R www:www /var/www/html
chmod -R 755 /var/www/html

exec /usr/sbin/php-fpm81 -F
