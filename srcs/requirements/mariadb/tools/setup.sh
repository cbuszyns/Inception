# MY_CNF_PATH="/etc/my.cnf"

# sed -i '/^\[mysqld\]/ { N; s/\[mysqld\]\n/default-storage-engine = aria\n/ }' "MY_CNF_PATH"

mysql_install_db --user=root

mysql_upgrade

mysqld --bind-address=127.0.0.1 --user=root --datadir=/data --skip-networking=0 & 
SQL_PID=$!

sleep 5

echo "[MariaDB Container] creating user"
echo "CREATE USER IF NOT EXISTS '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root

echo "[MariaDB Container] creating user"
echo "CREATE DATABASE mariadb;" | mysql -u root

echo "[MariaDB Container] granting privileges to user on the DB"
echo "GRANT ALL PRIVILEGES ON $MYSQL_WORDPRESS_DATABASE.* TO '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root

echo "FLUSH PRIVILEGES;" | mysql -u root

echo "[MariaDB Container] restarting the database"
kill $SQL_PID
wait $SQL_PID

mysqld --bind-adress=0.0.0.0 --user=root --datadir/data --skip-networking=0
