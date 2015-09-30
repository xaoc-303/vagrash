#!/usr/bin/env bash

echo "------------------------------"
echo "envoy"
echo "------------------------------"

sudo su vagrant <<'EOF'
composer global require "laravel/envoy=~1.0" --no-progress
echo "PATH=$PATH:~/.composer/vendor/bin" >> ~/.profile
source ~/.profile
envoy
EOF

# cd ~/.ssh
# ssh-keygen -t rsa -b 4096 -N ""
# ssh-copy-id -i root@example.com