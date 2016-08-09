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


nc -zv db 3306
while [ "$?" != 0 ]; do
  echo "Waiting for database..."
  nc -zv db 3306 2>/dev/null 1>&2
  sleep 2
done

# Initialize the database
./script/migrate

/usr/bin/supervisord
