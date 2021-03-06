#!/usr/bin/env bash

HOST_NAME=$1
LARAVEL_VERSION=$2

# [[ ! -f "/var/www/${HOST_NAME}/composer.json" ]] && { printf "!!! Project repo is not installed\n"; exit 0; }

if [ ! -f "/var/www/${HOST_NAME}/composer.json" ]; then
    # project directory must be empty, so...
    mkdir -p /var/www/${HOST_NAME}-temp
    composer create-project laravel/laravel=${LARAVEL_VERSION} /var/www/${HOST_NAME}-temp --prefer-dist --no-progress
    cp -r /var/www/${HOST_NAME}-temp/* /var/www/${HOST_NAME}/
    rm -rf /var/www/${HOST_NAME}-temp
    cd /var/www/${HOST_NAME}
sudo cat - > /var/www/${HOST_NAME}/.env.example.php <<EOF
<?php
return array(
    'DATABASE_HOST' => 'localhost',
    'DATABASE_NAME' => 'vagrash',
    'DATABASE_USER' => 'root',
    'DATABASE_PASSWORD' => 'pass'
);
EOF
    rm -rf vendor/compiled.php
    # composer clear-cache
    # composer update
fi
