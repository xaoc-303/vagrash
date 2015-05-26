#!/usr/bin/env bash
echo "------------------------------"
echo "download script extension local environment"
echo "------------------------------"

HOST_NAME=$1
URL_SCRIPT=$2

cd /var/www/${HOST_NAME}

if ! [ -a "setup-local.sh" ]; then
    wget -O setup-local.sh ${URL_SCRIPT}/scripts/setup-local.sh
fi
bash setup-local.sh ${HOST_NAME}
