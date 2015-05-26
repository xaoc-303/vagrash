#!/usr/bin/env bash

HOST_NAME=$1
IS_USED_QUEUE=$2

echo "------------------------------"
echo "other"
echo "------------------------------"

mkdir -p /var/www/${HOST_NAME}/public/temp

echo "download adminer"
if ! test -f "/var/www/${HOST_NAME}/public/temp/adminer.php"; then wget -O /var/www/${HOST_NAME}/public/temp/adminer.php https://www.dropbox.com/s/w2lmz9r5auaw5v3/adminer-4.1.0.php > /dev/null;fi

# sudo netstat -tlpnu | grep :1025
sudo netstat -anltp | grep "LISTEN"
# sudo nmap -O 127.0.0.1

date
sudo hwclock --show

# if IS_USED_QUEUE==true; then sudo echo "0-59 * * * * www-data cd /var/www/${HOST_NAME} && php artisan queue:supervisor --work" > /etc/cron.d/laravel;fi

echo "------------------------------"
