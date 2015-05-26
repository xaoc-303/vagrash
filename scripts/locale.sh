#!/usr/bin/env bash

echo "------------------------------"
echo "locale ru"
echo "------------------------------"
sudo apt-get -qq -y update
sudo apt-get -y install language-pack-ru-base > /dev/null
sudo apt-get -qq -y update

sudo locale-gen ru_RU.UTF-8
sudo update-locale LANG=ru_RU.UTF-8

sudo cat - > /etc/default/locale <<EOF
LANG=ru_RU.UTF-8
LANGUAGE=ru_RU.UTF-8
LC_CTYPE="ru_RU.UTF-8"
LC_NUMERIC="ru_RU.UTF-8"
LC_TIME="ru_RU.UTF-8"
LC_COLLATE="ru_RU.UTF-8"
LC_MONETARY="ru_RU.UTF-8"
LC_MESSAGES="ru_RU.UTF-8"
LC_PAPER="ru_RU.UTF-8"
LC_NAME="ru_RU.UTF-8"
LC_ADDRESS="ru_RU.UTF-8"
LC_TELEPHONE="ru_RU.UTF-8"
LC_MEASUREMENT="ru_RU.UTF-8"
LC_IDENTIFICATION="ru_RU.UTF-8"
LC_ALL=ru_RU.UTF-8
EOF

export LANG=ru_RU.UTF-8
export LANGUAGE=ru_RU.UTF-8
#export LC_CTYPE=ru_RU.UTF-8
#export LC_NUMERIC=ru_RU.UTF-8
#export LC_TIME=ru_RU.UTF-8
#export LC_COLLATE=ru_RU.UTF-8
export LC_MONETARY=ru_RU.UTF-8
#export LC_MESSAGES=ru_RU.UTF-8
export LC_PAPER=ru_RU.UTF-8
export LC_NAME=ru_RU.UTF-8
export LC_ADDRESS=ru_RU.UTF-8
export LC_TELEPHONE=ru_RU.UTF-8
export LC_MEASUREMENT=ru_RU.UTF-8
export LC_IDENTIFICATION=ru_RU.UTF-8
#export LC_ALL=ru_RU.UTF-8

cat /etc/default/locale

# glibc-locale
# sudo localedef -c -i ru_RU -f UTF-8 ru_RU.UTF-8
sudo dpkg-reconfigure locales
