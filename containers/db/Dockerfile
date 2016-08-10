FROM alpine:3.3
#FROM multiarch/alpine:armhf-v3.3

RUN apk --no-cache add mariadb mariadb-client && rm -rf /var/cache/apk/*

VOLUME /var/lib/mysql

ADD docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh

CMD ["/root/docker-entrypoint.sh"]
