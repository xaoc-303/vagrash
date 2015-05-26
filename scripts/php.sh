#!/usr/bin/env bash

echo "------------------------------"
echo "php"
echo "------------------------------"

sudo apt-get -y install software-properties-common python-software-properties lynx tmux > /dev/null
sudo apt-get -qq -y update
sudo add-apt-repository ppa:ondrej/php5 -y > /dev/null
sudo apt-get -qq -y update

sudo apt-get -y install php5 php5-fpm php5-dev php5-cli php5-curl php5-mcrypt php5-mysql php5-pgsql php-mail php5-memcached > /dev/null
sudo apt-get -qq -y update

# sudo sh -c "sed -i '/memory_limit/s/128M/512M/' /etc/php5/cli/php.ini"
# sudo sh -c "sed -i '/post_max_size/s/8M/80M/' /etc/php5/cli/php.ini"
# sudo sh -c "sed -i '/upload_max_filesize/s/2M/2000M/' /etc/php5/cli/php.ini"
sudo sh -c "sed -i '/short_open_tag/s/Off/On/g' /etc/php5/fpm/php.ini"

sudo service php5-fpm restart

echo "------------------------------"
echo "composer"
echo "------------------------------"

curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer