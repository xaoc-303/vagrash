#!/usr/bin/env bash
echo "------------------------------"
echo "extension local environment"
echo "------------------------------"

HOST_NAME=$1

[[ ! -f "/var/www/${HOST_NAME}/composer.json" ]] && { printf "!!! Project repo is not installed\n"; exit 0; }

# sudo echo "0-59 * * * * www-data cd /var/www/${HOST_NAME} && php artisan queue:supervisor --work" > /etc/cron.d/laravel

cd /var/www/${HOST_NAME}

echo "set local values"
if ! test -f ".env.local.php"; then
    cp .env.example.php .env.local.php > /dev/null
fi

echo "composer update"
composer update --no-progress > /dev/null

echo "ide-helper:generate"
php artisan ide-helper:generate

echo "migrate:install"
php artisan migrate:install

echo "migrate:refresh"
php artisan migrate:refresh

echo "db:seed"
php artisan db:seed
