FROM alpine:3.3

ARG KARAMBOL_REPOSITORY=https://github.com/Bornholm/karambol.git
ARG KARAMBOL_TAG=develop

RUN apk --no-cache add php-fpm \
  php-pdo php-mysql php-pdo_mysql \
  php-openssl php-mcrypt php-zlib php-phar php-dom php-ctype \
  php-json php-curl php-xml php-opcache php-apcu \
  nginx curl supervisor git bash \
  && rm -rf /var/cache/apk/*

ADD supervisor.ini /etc/supervisor.d/supervisor.ini

RUN mkdir -p /etc/nginx
RUN mkdir -p /var/run/php-fpm
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /opt

RUN rm /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx-karambol.conf /etc/nginx/sites-enabled/karambol.conf

WORKDIR /opt
RUN git clone "$KARAMBOL_REPOSITORY" karambol
WORKDIR /opt/karambol
RUN git checkout "$KARAMBOL_TAG"

RUN ./bin/install

ADD docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh

RUN mkdir -p /container-lifecycle/first-start
ADD first-start.sh /container-lifecycle/first-start/00-karambol
RUN chmod +x /container-lifecycle/first-start/00-karambol

RUN mkdir -p /container-lifecycle/start
ADD start.sh /container-lifecycle/start/00-karambol
RUN chmod +x /container-lifecycle/start/00-karambol

EXPOSE 80

CMD ["/root/docker-entrypoint.sh"]
