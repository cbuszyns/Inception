# MY_CNF_PATH="/etc/my.cnf"

# sed -i '/^\[mysqld\]/ { N; s/\[mysqld\]\n/default-storage-engine = aria\n/ }' "$MY_CNF_PATH"

echo "[Inception-MariaDB] Initializing the database"

mysql_install_db --user=root

mysql_upgrade

mysqld --bind-address=127.0.0.1 --user=root --datadir=/data --skip-networking=0 &
SQL_PID=$!

sleep 5

echo "[MariaDB Container]Creating user"
echo "CREATE USER IF NOT EXISTS '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root


echo "[MariaDB Container]Creating database"
echo "CREATE DATABASE mariadb;" | mysql -u root

echo "[MariaDB Container]Granting privileges to user on the DB"
echo "GRANT ALL PRIVILEGES ON $MYSQL_WORDPRESS_DATABASE.* TO '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root

echo "FLUSH PRIVILEGES;" | mysql -u root

echo "[MariaDB Container] Restarting the database"
kill $SQL_PID
wait $SQL_PID

mysqld --bind-address=0.0.0.0 --user=root --datadir=/data --skip-networking=0