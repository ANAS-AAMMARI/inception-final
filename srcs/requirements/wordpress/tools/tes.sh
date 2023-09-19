#!/bin/sh

# install wp-cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# make it executable
chmod +x wp-cli.phar

# move it to path
mv wp-cli.phar /usr/local/bin/wp

# install wordpress
# wp core download --path=/var/www --allow-root

# download wordpress
wget https://wordpress.org/latest.tar.gz

# extract wordpress
tar -xvf latest.tar.gz

# move wordpress to /var/www/html
mv wordpress/* /var/www/html
rm -rf wordpress
rm -rf latest.tar.gz


# create wp-config.php
wp config create --allow-root \
    --dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$USER_PASS \
    --dbhost=mariadb:3306 --skip-check \
    --path=/var/www/html

# # create admin user for wordpress
wp core install --allow-root \
    --url=$WP_URL \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASS\
    --admin_email=$WP_ADMIN_EMAIL \
    --path=/var/www/html

# # create normal user for wordpress
wp user create --allow-root \
    $WP_USER \
    $WP_USER_EMAIL \
    --user_pass=$WP_USER_PASS \
    --role=author \
    --path=/var/www/html

php-fpm81 -F