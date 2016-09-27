#!/bin/sh

if [ ! -f "/container-lifecycle/.flags/first-start" ]; then
  [ -d /container-lifecycle/first-start ] && run-parts /container-lifecycle/first-start
  mkdir -p "/container-lifecycle/.flags"
  touch "/container-lifecycle/.flags/first-start"
fi

[ -d /container-lifecycle/start ] && run-parts /container-lifecycle/start

mysqld_safe --datadir='/var/lib/mysql'
