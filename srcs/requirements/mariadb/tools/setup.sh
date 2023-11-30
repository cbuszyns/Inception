#!/bin/sh

mysql_install_db


mysqld --bind-address=127.0.0.1 --user=root --datadir=/data --skip-networking=0 &
SQL_PID=$!

sleep 5

echo "[MariaDB Container] creating user"
echo "CREATE USER '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root

echo "[MariaDB Container] creating database"
echo "CREATE DATABASE $MYSQL_WORDPRESS_DATABASE;" | mysql -u root

echo "[MariaDB Container] granting privileges to user on the DB"
echo "GRANT ALL PRIVILEGES on wordpress.* TO '$MYSQL_USERNAME'@'%';" | mysql -u root

#echo "FLUSH PRIVILEGES;" | mysql -u root

echo "[MariaDB Container] restarting the database"
kill $SQL_PID
wait $SQL_PID

mysqld --bind-address=0.0.0.0 --user=root --datadir=/data --skip-networking=0