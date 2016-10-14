#!/bin/sh

cd /opt/karambol

./bin/cli zoco-plugin:boamp:fetch-archives --force-sync --newer-than=P1D
./bin/cli zoco-plugin:boamp:extract-archives --newer-than=P1D

http_proxy= https_proxy= HTTP_PROXY= HTTPS_PROXY= ./bin/cli zoco-plugin:boamp:parse-xml --newer-than=P1D --bulk-size=500
