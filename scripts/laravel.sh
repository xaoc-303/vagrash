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

if test -d /var/www/$HOST_NAME
    then

    cd /var/www/$HOST_NAME
    echo "download php-cs-fixer"
    if ! test -f "php-cs-fixer.phar"; then wget http://get.sensiolabs.org/php-cs-fixer.phar > /dev/null;fi

    mkdir -p public/temp && cd public/temp
    echo "download adminer"
    if ! test -f "adminer.php"; then wget -O adminer.php https://www.dropbox.com/s/d9pt98r6mj69c7s/adminer-4.2.1.php > /dev/null;fi

fi