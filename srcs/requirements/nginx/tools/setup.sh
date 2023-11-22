echo "[WEB-Server] creating SSL Certificate"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/cbuszyns.42.fr -subj "/C=IT/L=ROME/O=42ROMA/OU=STUDENT/CN=cbuszyns.42.fr"

mkdir -p /etc/nginx/sites-aviable/
mkdir -p /etc/ngnix/sites-enabled/

echo "[WEB-Server]"
nginx -g "daemon off"
