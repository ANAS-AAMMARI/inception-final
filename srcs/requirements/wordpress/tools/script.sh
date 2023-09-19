#!/bin/sh

cd /var/www/html

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# make wp-cli.phar executable
chmod +x wp-cli.phar

# move wp-cli.phar to /usr/local/bin/wp
mv wp-cli.phar /usr/local/bin/wp

# download wordpress
wp core download --allow-root

# create wp-config.php for wordpress
wp config create --allow-root \
    --dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$USER_PASS \
    --dbhost=mariadb --skip-check

# create admin user for wordpress
wp core install --allow-root \
    --url=$WP_URL \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASS \
    --admin_email=$WP_ADMIN_EMAIL 

# create user for wordpress
wp user create --allow-root \
    $WP_USER \
    $WP_USER_EMAIL \
    --role=author \
    --user_pass=$WP_USER_PASS

# start php-fpm forground
php-fpm81 -F