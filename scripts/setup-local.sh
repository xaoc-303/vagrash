#!/usr/bin/env bash
echo "------------------------------"
echo "extension local environment"
echo "------------------------------"

HOST_NAME=$1

[[ ! -f "/var/www/${HOST_NAME}/composer.json" ]] && { printf "!!! Project repo is not installed\n"; exit 0; }

# sudo echo "0-59 * * * * www-data cd /var/www/${HOST_NAME} && php artisan queue:supervisor --work" > /etc/cron.d/laravel

mkdir -p /var/www/${HOST_NAME}/public/temp
echo "download adminer"
if ! test -f "/var/www/${HOST_NAME}/public/temp/adminer.php"; then wget -O /var/www/${HOST_NAME}/public/temp/adminer.php https://www.dropbox.com/s/d9pt98r6mj69c7s/adminer-4.2.1.php > /dev/null;fi

cd /var/www/${HOST_NAME}

echo "download php-cs-fixer"
if ! test -f "php-cs-fixer.phar"; then wget http://get.sensiolabs.org/php-cs-fixer.phar > /dev/null;fi

# ------------------------------

echo "set local values"
if ! test -f ".env.local.php"; then
    cp .env.example.php .env > /dev/null
fi

echo "composer update"
composer update > /dev/null

echo "ide-helper:generate"
php artisan ide-helper:generate

echo "migrate:install"
php artisan migrate:install

echo "migrate:refresh"
php artisan migrate:refresh

echo "db:seed"
php artisan db:seed
