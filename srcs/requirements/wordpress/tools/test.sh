#!/bin/sh


# # download wordpress use WP-CLI instead
# wget https://wordpress.org/latest.tar.gz
# # unpack wordpress
# tar -xf latest.tar.gz
# download cli for wordpress
# download wordpress with wp-cli allowing the root user to do so

# while ! mysql -u $DB_USER -p $DB_USER_PASSWORD -h mariadb $DB_NAME; do
# 	sleep 5
# done

cd /var/www/html/
wp core download --allow-root

# change directory to where you want them first (may need to make one)


#setup with the wp-cli https://www.cloudways.com/blog/wp-cli-commands/
# make config
#skip check to be removed once database is connected and running
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=mariadb --path=/var/www/html/ --force

# install wordpress
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --path=/var/www/html/ --allow-root
# make user
# --path=/var/www/html maybe set as same location as volume
wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PASSWORD --path=/var/www/html/
# install themes and plugins
wp theme install pixl --activate
# activate stuff e.g. themes
# wp theme activate pixl
wp plugin update --all

wp option update siteurl "https://$DOMAIN_NAME"
wp option update home "https://$DOMAIN_NAME"

# while [ true ] 
# do
# 	sleep 1
# done
chown -R nginx:nginx /var/www/html
chmod -R 755 /var/www/html/wordpress

exec php-fpm81
