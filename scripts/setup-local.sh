#!/usr/bin/env bash
echo "------------------------------"
echo "extension local environment"
echo "------------------------------"

HOST_NAME=$1

[[ ! -f "/var/www/${HOST_NAME}/composer.json" ]] && { printf "!!! Project repo is not installed\n"; exit 0; }

# sudo echo "0-59 * * * * www-data cd /var/www/${HOST_NAME} && php artisan queue:supervisor --work" > /etc/cron.d/laravel

cd /var/www/$HOST_NAME

# git checkout -b develop origin/develop

echo "set local values"
if ! test -f ".env.local.php"; then
    cp .env.example.php .env.local.php > /dev/null
fi

echo "composer update"
composer install --no-progress > /dev/null
composer update --no-progress > /dev/null

php artisan key:generate

echo "ide-helper:generate"
php artisan ide-helper:generate

echo "migrate:install"
php artisan migrate:install

echo "migrate:refresh"
php artisan migrate:refresh

echo "db:seed"
php artisan db:seed

# nodejs node_modules/gulp/bin/gulp.js build

# sudo sh -c "echo \"0-59 * * * * www-data cd /var/www/$HOST_NAME && php artisan schedule:run 1>> /dev/null 2>&1\" > /etc/cron.d/laravel"