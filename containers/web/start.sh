#!/bin/bash

cd /opt/karambol

while ! (echo > /dev/tcp/db/3306) >/dev/null 2>&1; do
  echo "Waiting for database..."
  sleep 2;
done;

echo "Clearing cache..."
./bin/cli karambol:cache:clear

echo "Linking assets..."
./bin/cli karambol:assets:link

echo "Updating database schema..."
./bin/migrate
