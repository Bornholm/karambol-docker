#!/bin/bash

echo "Initializing Karambol..."

./script/install
./script/migrate

echo "y\n" | ./script/console karambol:rules:seed
./script/console karambol:account:create "${KARAMBOL_ADMIN_USER}" "${KARAMBOL_ADMIN_PASSWORD}"
./script/console karambol:account:promote "${KARAMBOL_ADMIN_USER}"

# Create and update files ACL
mkdir -p public/cache
chown -R nobody: public/cache
