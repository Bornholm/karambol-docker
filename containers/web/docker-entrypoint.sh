#!/bin/bash

# Create/Update local configuration
cat <<EOF > config/local.d/local.yml
debug: false

logger:
  level: WARNING

database:
  driver: pdo_mysql
  user: $MYSQL_USER
  password: $MYSQL_PASSWORD
  dbname: $MYSQL_DATABASE
  host: db
EOF

while ! (echo > /dev/tcp/db/3306) >/dev/null 2>&1; do
  echo "Waiting for database..."
  sleep 2;
done;

if [ ! -f ".initialized" ]; then
  run-parts /opt/karambol/init
  touch ".initialized"
fi

/usr/bin/supervisord
