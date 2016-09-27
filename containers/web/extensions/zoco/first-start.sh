#!/bin/bash

echo "Initializing Zoco plugin..."

# Copie du fichier de configuration par défaut de Zoco
cp vendor/bornholm/karambol-plugin-zoco/config/zoco.yml config/local.d/

# Configuration d'Elasticsearch
sed -i 's/127\.0\.0\.1/elasticsearch/' config/local.d/zoco.yml

# Activation du plugin
KARAMBOL_SETTINGS=config/local.d/_settings.yml
if [ -f "$KARAMBOL_SETTINGS" ]; then
  echo "  enable_plugin_zoco: true" >> "$KARAMBOL_SETTINGS"
else
  cat <<EOF > "$KARAMBOL_SETTINGS"
settings:
  enable_plugin_zoco: true
EOF
fi

chown nobody: config/local.d/_settings.yml

# Migration de la BDD
./script/migrate

# Création de l'index
http_proxy= https_proxy= HTTP_PROXY= HTTPS_PROXY= ./script/cli zoco-plugin:index:create
