FROM alpine:3.17


RUN apk add nginx openssl apache2-utils
RUN mkdir -p /etc/ssl
RUN mkdir -p /etc/nginx/

COPY config/nginx.conf /etc/nginx/http.d/
COPY tools/setup.sh /usr/local/bin/

EXPOSE 443

ENTRYPOINT ["/bin/sh", "/usr/local/bin/setup.sh"]
