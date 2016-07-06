#!/usr/bin/env bash

HOST_NAME=$1

if test -d /var/www/$HOST_NAME
	then

	cd /var/www/$HOST_NAME
	echo "download php-cs-fixer"
	if ! test -f "php-cs-fixer.phar"; then wget http://get.sensiolabs.org/php-cs-fixer.phar > /dev/null;fi

	echo "phpunit"
	if ! test -f "phpunit.phar"; then wget https://phar.phpunit.de/phpunit.phar > /dev/null;fi
	if ! test -f "phpunit-old.phar"; then wget https://phar.phpunit.de/phpunit-old.phar > /dev/null;fi
fi
