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

nc -zv db 3306 2>/dev/null 1>&2
while [ "$?" != 0 ]; do
  echo "Waiting for database..."
  sleep 2
  nc -zv db 3306 2>/dev/null 1>&2
done

if [ ! -e .initialized ]; then

  echo "Initializing Karambol..."

  ./script/migrate
  echo "y\n" | ./script/console karambol:rules:seed
  ./script/console karambol:account:create "${KARAMBOL_ADMIN_USER}" "${KARAMBOL_ADMIN_PASSWORD}"
  ./script/console karambol:account:promote "${KARAMBOL_ADMIN_USER}"


  # Create and update files ACL
  mkdir -p public/cache
  chown -R nobody: public/cache

  [ ! -z "${STARTUP_HOOKS}" ] && run-parts "${STARTUP_HOOKS}"

  touch .initialized

fi

/usr/bin/supervisord
