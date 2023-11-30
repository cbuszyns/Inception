#!/bin/sh

echo "[WEB-Server] creating SSL Certificate"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/cbuszyns.42.fr.key -out /etc/ssl/cbuszyns.42.fr.crt -subj "/C=IT/L=ROME/O=42ROMA/OU=STUDENT/CN=cbuszyns.42.fr"

mkdir -p /etc/nginx/sites-available/
mkdir -p /etc/nginx/sites-enabled/

echo "[WEB-Server]"
nginx -g "daemon off;"

