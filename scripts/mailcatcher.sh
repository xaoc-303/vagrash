#!/usr/bin/env bash

echo "------------------------------"
echo "mail, sendmail, mailcatcher"
echo "------------------------------"

sudo apt-get -y install php-mail sendmail sasl2-bin mailutils > /dev/null
sudo apt-get -qq -y update

sudo sed -i '$ a \\n127.0.0.1 localhost localhost.localdomain\n' /etc/hosts
sudo /etc/init.d/networking restart

# mailcatcher

# sudo apt-get install -y vim curl python-software-properties lynx nginx
# sudo apt-get install -y php5-fpm php5-memcache memcached php-apc
# sudo apt-get install -y build-essential libsqlite3-dev ruby1.9.3
# sudo apt-get -y update
# sudo gem install mailcatcher

# sendmail_path = /usr/bin/env $(which catchmail)
# /usr/local/bin/catchmail

sudo apt-get -y install build-essential libsqlite3-dev ruby1.9.1-dev > /dev/null
sudo apt-get -qq -y update
sudo gem install mailcatcher

sudo cat - > /etc/init/mailcatcher.conf <<EOF
description "Run the Mailcatcher"

start on runlevel [2]
stop on runlevel [!2]

respawn

exec /usr/bin/env \$(which mailcatcher) --foreground --ip=0.0.0.0
EOF
sudo initctl reload-configuration

# echo 'echo "@reboot root $(which mailcatcher) --ip=0.0.0.0" >> /etc/crontab' | sudo -s
# sudo sh -c "sed -i '/;sendmail_path/s/;sendmail_path =/sendmail_path = \/usr\/bin\/env \/usr\/local\/bin\/catchmail/' /etc/php5/fpm/php.ini"
echo "sendmail_path = /usr/bin/env $(which catchmail)" | sudo tee /etc/php5/mods-available/mailcatcher.ini
sudo php5enmod mailcatcher
sudo service apache2 restart
# sudo sh -c "sed -i '/;sendmail_path/s/;sendmail_path =/sendmail_path = \/usr\/sbin\/sendmail -t -i/' /etc/php5/fpm/php.ini"
sudo service php5-fpm restart

sudo sed -i "36iinclude(\`\/etc\/mail\/tls\/starttls.m4\')dnl" /etc/mail/sendmail.mc
sudo /etc/init.d/sendmail restart
sudo /usr/sbin/sendmail -d0.1 -bv root
