#!/bin/bash

echo "Initializing Karambol..."

echo "Creating local configuration..."
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

./script/install
./script/migrate

echo "y\n" | ./script/cli karambol:rules:seed
./script/cli karambol:account:create "${KARAMBOL_ADMIN_USER}" "${KARAMBOL_ADMIN_PASSWORD}"
./script/cli karambol:account:promote "${KARAMBOL_ADMIN_USER}"

# Create and update files ACL
mkdir -p public/cache
chown -R nobody: public/cache
