#!/bin/sh

while ! mysql -h${MYSQL_HOSTNAME} -u${MYSQL_USERNAME} -p${MYSQL_PASSWORD} ${MYSQL_WORDPRESS_DATABASE} -e ";" &> /dev/null; do
	echo "waiting for mariadb..."
	sleep 3
done

cd /var/www/html

if [ ! -f "/var/www/html/index.html" ]; then
	echo "[WP Container] It seems that wp-cli isn't installed, installing it right now..."

	echo "nameserver 8.8.8.8" >> /etc/resolv.conf
	echo "nameserver 8.8.4.4" >> /etc/resolv.conf

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	php wp-cli.phar --info

	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	wp cli update

	wp core download --allow-root
	echo "[WP Container] wp-cli installed and updated!"

	wp config create 							\
		--dbname=${MYSQL_WORDPRESS_DATABASE} 	\
		--dbuser=${MYSQL_USERNAME}			 	\
		--dbpass=${MYSQL_PASSWORD} 				\
		--dbhost=${MYSQL_HOSTNAME} 					\
		--dbcollate="utf8_general_ci" 			\
		--allow-root
	
	wp core install \
		--url=${DOMAIN_NAME}/wordpress \
		--title=${WORDPRESS_TITLE} \
		--admin_user=${WORDPRESS_ADMIN_NAME} \
		--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
		--admin_email=${WORDPRESS_ADMIN_EMAIL} \
		--skip-email \
		--allow-root

	wp user create ${WORDPRESS_USER_NAME} ${WORDPRESS_USER_EMAIL} \
		--role=subscriber \
		--user_pass=${WORDPRESS_USER_PASSWORD} \
		--allow-root
fi

sed "s/127.0.0.1:9000/0.0.0.0:9000/1" -i -r /etc/php81/php-fpm.d/www.conf

echo "[WP Contaier] starting php-fpm"
/usr/sbin/php-fpm81 -F -R
