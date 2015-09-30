#!/usr/bin/env bash

echo "------------------------------"
echo "local nodejs npm"
echo "------------------------------"

sudo apt-get -y install nodejs-legacy > /dev/null 2>&1
sudo apt-get -y install npm > /dev/null 2>&1
# npm install > /dev/null 2>&1