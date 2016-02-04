#!/usr/bin/env bash

echo "------------------------------"
echo "envoy"
echo "------------------------------"

sudo su vagrant <<'EOF'
composer global require "laravel/envoy=~1.0" --no-progress

PATH_FILE="/home/vagrant/.config/composer/vendor/bin"
if [ -h "$PATH_FILE/envoy" ]; then PATH_FIND=$PATH_FILE;fi

PATH_FILE="/home/vagrant/.composer/vendor/bin"
if [ -h "$PATH_FILE/envoy" ]; then PATH_FIND=$PATH_FILE;fi

if [ ! -z $PATH_FIND ]; then
echo "PATH=\$PATH:$PATH_FIND" >> /home/vagrant/.profile
source /home/vagrant/.profile
envoy
else
echo "The file 'envoy' does not exist"
fi
EOF

# cd ~/.ssh
# ssh-keygen -t rsa -b 4096 -N ""
# ssh-copy-id -i root@example.com