FROM alpine:3.17

RUN apk add curl php php-fpm php-mysqli php-curl php-dom php-exif php-fileinfo php-xml php-zip php-phar php-tokenizer
RUN apk add mysql-client
RUN mkdir -p /var/www/html

COPY tools/setup.sh /usr/local/bin/

EXPOSE 9000

ENTRYPOINT ["bin/sh", "/usr/local/bin/setup.sh"]
