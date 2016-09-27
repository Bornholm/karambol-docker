#!/bin/sh

cd /opt/karambol

./script/cli zoco-plugin:boamp:fetch-archives --force-sync --newer-than=P1D
./script/cli zoco-plugin:boamp:extract-archives --newer-than=P1D

http_proxy= https_proxy= HTTP_PROXY= HTTPS_PROXY= ./script/cli zoco-plugin:boamp:parse-xml --newer-than=P1D --bulk-size=500
