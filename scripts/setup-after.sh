#!/usr/bin/env bash

HOST_NAME=$1

echo "------------------------------"
echo "other"
echo "------------------------------"

if test -d /var/www/$HOST_NAME
	then

	cd /var/www/$HOST_NAME
	echo "download php-cs-fixer"
	if ! test -f "php-cs-fixer.phar"; then wget http://get.sensiolabs.org/php-cs-fixer.phar > /dev/null;fi

	echo "phpunit"
	if ! test -f "https://phar.phpunit.de/phpunit.phar"; then wget https://phar.phpunit.de/phpunit.phar > /dev/null;fi
	if ! test -f "https://phar.phpunit.de/phpunit-old.phar"; then wget https://phar.phpunit.de/phpunit-old.phar > /dev/null;fi

	mkdir -p public/temp && cd public/temp
	echo "download adminer"
	if ! test -f "adminer.php"; then wget -O adminer.php https://www.dropbox.com/s/d9pt98r6mj69c7s/adminer-4.2.1.php > /dev/null;fi

fi

# sudo netstat -tlpnu | grep :1025
sudo netstat -anltp | grep "LISTEN"
# sudo nmap -O 127.0.0.1

date
sudo hwclock --show

echo "------------------------------"
