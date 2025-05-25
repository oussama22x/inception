#!/bin/sh


chown -R mysql:mysql /var/lib/mysql

service mariadb start
sleep 2

mariadb  -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mariadb  -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mariadb  -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mariadb  -e "FLUSH PRIVILEGES;"

service mariadb stop
#for unexpected crashes

exec mysqld_safe
#main procese inside the container 