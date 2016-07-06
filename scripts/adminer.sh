#!/usr/bin/env bash

HOST_NAME=$1
PUBLIC_FOLDER=$2

if test -d /var/www/$HOST_NAME
	then

	cd /var/www/$HOST_NAME
	mkdir -p .$PUBLIC_FOLDER && cd .$PUBLIC_FOLDER
	echo "download adminer"
	if ! test -f "adminer.php"; then wget -O adminer.php https://www.dropbox.com/s/d9pt98r6mj69c7s/adminer-4.2.1.php > /dev/null;fi
fi
