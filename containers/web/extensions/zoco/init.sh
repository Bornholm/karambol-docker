#!/bin/bash

echo "Initializing Zoco..."

./script/migrate

http_proxy= https_proxy= HTTP_PROXY= HTTPS_PROXY= ./script/console zoco-plugin:index:create
