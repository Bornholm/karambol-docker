FROM alpine:3.3
#FROM multiarch/alpine:armhf-v3.3

ARG ELASTICSEARCH_VERSION=2.3.5

RUN apk --no-cache add curl ca-certificates openjdk8-jre && rm -rf /var/cache/apk/*

ENV PATH=${PATH}:/opt/elasticsearch-$ELASTICSEARCH_VERSION/bin

RUN mkdir -p /opt && \
  curl -Ls https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.5/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz | tar -xz -C /opt

ADD elasticsearch.yml /opt/elasticsearch-$ELASTICSEARCH_VERSION/config/elasticsearch.yml

ADD docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh

EXPOSE 9200

CMD ["/root/docker-entrypoint.sh"]
