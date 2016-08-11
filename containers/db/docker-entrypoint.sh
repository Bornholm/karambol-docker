#!/bin/sh

if [ ! -f "/root/.initialized" ]; then

  echo "Initialising MariaDB instance..."
  mysql_install_db --user=mysql

  # Only listen on localhost when installing
  sed -i 's/\[mysqld\]/\[mysqld\]\nbind-address = 127.0.0.1/' /etc/mysql/my.cnf

  /usr/bin/mysqld_safe &

  nc -zv 127.0.0.1 3306 2>/dev/null 1>&2
  while [ "$?" != 0 ]; do
    echo "Waiting for MariaDB to boot..."
    sleep 2
    nc -zv 127.0.0.1 3306 2>/dev/null 1>&2
  done

  echo -e "\ny\n${MYSQL_ROOT_PASSWORD}\n${MYSQL_ROOT_PASSWORD}\ny\ny\ny\ny\n" | mysql_secure_installation

  echo "\
    CREATE DATABASE \`${MYSQL_DATABASE}\`; \
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO ${MYSQL_USER}@'%' \
    IDENTIFIED BY '${MYSQL_PASSWORD}'; \
    FLUSH PRIVILEGES; \
  " | mysql -u root --password="${MYSQL_ROOT_PASSWORD}"

  mysqladmin -uroot --password="${MYSQL_ROOT_PASSWORD}" shutdown
  sleep 2

  sed -i 's/bind-address = 127.0.0.1//' /etc/mysql/my.cnf

  [ ! -z "${STARTUP_HOOKS}" ] && run-parts "${STARTUP_HOOKS}"

  touch "/root/.initialized"

fi

mysqld_safe
