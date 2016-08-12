FROM resin/rpi-raspbian:wheezy

# Install dependencies
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get install -y oracle-java8-installer curl ca-certificates

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Set locales
RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LC_CTYPE fr_FR.UTF-8

ARG ELASTICSEARCH_VERSION=2.3.5
ARG ELASTICSEARCH_DL_BASE_URL=https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch

RUN mkdir -p /opt && \
  curl -Ls $ELASTICSEARCH_DL_BASE_URL/$ELASTICSEARCH_VERSION/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz | tar -xz -C /opt

ADD elasticsearch.yml /opt/elasticsearch-$ELASTICSEARCH_VERSION/config/elasticsearch.yml

ADD docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh

EXPOSE 9200

CMD ["/root/docker-entrypoint.sh"]
