#!/bin/bash

while [ true ] 
do
	sleep 1
done

# # download wordpress use WP-CLI instead
# wget https://wordpress.org/latest.tar.gz
# # unpack wordpress
# tar -xf latest.tar.gz
# download cli for wordpress
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
# change permissions 
chmod +x /usr/local/bin/wp
# download wordpress with wp-cli allowing the root user to do so
# change directory to where you want them first (may need to make one)
wp core download --allow-root

#setup with the wp-cli https://www.cloudways.com/blog/wp-cli-commands/
# make config

# install wordpress

# install themes and plugins

# activate stuff e.g. themes
