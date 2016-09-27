FROM alpine:3.3
#FROM multiarch/alpine:armhf-v3.3

RUN apk --no-cache add mariadb mariadb-client bash && rm -rf /var/cache/apk/*

VOLUME /var/lib/mysql

RUN mkdir -p /container-lifecycle/first-start
ADD first-start.sh /container-lifecycle/first-start/00-mysql
RUN chmod +x /container-lifecycle/first-start/00-mysql

ADD docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh

CMD ["/root/docker-entrypoint.sh"]
