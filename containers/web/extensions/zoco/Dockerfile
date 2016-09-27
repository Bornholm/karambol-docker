# Script d'installation de Zoco dans l'environnement Karambol

ARG ZOCO_PLUGIN_VERSION=dev-develop

# Installation des dépendances systèmes
RUN apk add --no-cache php-ftp tar gzip sed && rm -rf /var/cache/apk/*

# Ajout de la dépendances vers Zoco dans le manifeste des paquets PHP de Karambol
ADD extensions/zoco/composer.local.json /opt/karambol/composer.local.json
RUN sed -i "s/\${ZOCO_PLUGIN_VERSION}/$ZOCO_PLUGIN_VERSION/" /opt/karambol/composer.local.json

# Mise à jour des dépendances PHP
RUN ./composer update bornholm/karambol-plugin-zoco

# Création du script de mise à jour des données du BOAMP
ADD extensions/zoco/fetch-latest-boamp.sh /etc/periodic/daily/fetch-latest-boamp
RUN chmod a+x /etc/periodic/daily/fetch-latest-boamp

# Mise en place de la tâche journalière de synchro des données du BOAMP
ADD extensions/zoco/cron.ini /etc/supervisor.d/cron.ini

RUN mkdir -p /container-lifecycle/first-start
ADD extensions/zoco/first-start.sh /container-lifecycle/first-start/10-zoco
RUN chmod +x /container-lifecycle/first-start/10-zoco
