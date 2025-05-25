#!/bin/bash

if [ -f ./wp-config.php ];
then
    echo "Wordpress is already installed"
else
    cd /var/www

    wget https://wordpress.org/latest.tar.gz
    tar xfz latest.tar.gz
    rm -rf latest.tar.gz
    cd wordpress

    cp wp-config-sample.php wp-config.php
    sed -i "s/username_here/$DB_USER/g" wp-config.php
    sed -i "s/password_here/$DB_PASSWORD/g" wp-config.php
    sed -i "s/localhost/$HOST/g" wp-config.php
    sed -i "s/database_name_here/$DB_NAME/g" wp-config.php

    wp core install --url=$DOMAIN_NAME --title="inception" --admin_user=$DB_USER --admin_password=$DB_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path=/var/www/wordpress
    wp user create $USER $USER_EMAIL --role=author --user_pass=$USER_PASSWORD --allow-root --path=/var/www/wordpress

    echo "Wordpress is installed"
fi

exec php-fpm7.4 -F
