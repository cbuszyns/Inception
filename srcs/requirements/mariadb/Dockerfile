FROM alpine:3.17.5

EXPOSE 3306

COPY ./tools/setup.sh /usr/local/bin/

RUN apk update && apk add mysql mysql-client
#mariadb mariadb-client

RUN mkdir /run/mysqld

ENTRYPOINT ["/bin/sh", "/usr/local/bin/setup.sh"]
