#!/usr/bin/env bash

echo "------------------------------"
echo "php"
echo "------------------------------"

sudo apt-get -y install software-properties-common python-software-properties lynx tmux > /dev/null
sudo add-apt-repository -y ppa:ondrej/php5 > /dev/null
# sudo add-apt-repository -y ppa:ondrej/php5-5.6
sudo apt-get -qq -y update

sudo apt-get -y install php5 php5-fpm php5-dev php5-intl \
php5-cli php5-curl php5-mcrypt php5-json php5-mysql php5-pgsql \
php5-gd php5-gmp php5-imagick php-mail php5-memcached php5-xdebug > /dev/null

# sudo sh -c "sed -i '/memory_limit/s/128M/512M/' /etc/php5/cli/php.ini"
# sudo sh -c "sed -i '/post_max_size/s/8M/80M/' /etc/php5/cli/php.ini"
# sudo sh -c "sed -i '/upload_max_filesize/s/2M/2000M/' /etc/php5/cli/php.ini"
sudo sh -c "sed -i '/short_open_tag/s/Off/On/g' /etc/php5/fpm/php.ini"

sudo service php5-fpm restart
