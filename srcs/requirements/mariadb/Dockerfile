FROM alpine:3.17

EXPOSE 3306

RUN apk add mysql mysql-client
#mariadb mariad-client
COPY tools/setup.sh /usr/local/bin/

RUN mkdir /run/mysqld

ENTRYPOINT ["/bin/sh", "/usr/local/bin/setup.sh"]
