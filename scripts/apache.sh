#!/usr/bin/env bash

echo "------------------------------"
echo "apache"
echo "------------------------------"

HOST_NAME=$1

sudo apt-get -y install apache2 libapache2-mod-php5 libssh2-php > /dev/null

# pecl http
# apt-get -y install php-pear php-http libcurl3 libpcre3-dev libcurl4-openssl-dev build-essential
# sudo pecl install pecl_http-1.7.6
# sudo sed -i '952iextension=http.so' /etc/php5/cli/php.ini
# sudo sed -i '952iextension=http.so' /etc/php5/apache2/php.ini

# sudo rm /etc/apache2/sites-enabled/000-default.conf
sudo a2dissite 000-default

sudo cat - > my.conf <<EOF
## Файл персональных настроек веб-сервера Apache

## Чтобы устранить предупреждение при перезапуске Apache (хотя в целом на производительности это не отразится)
ServerName localhost

## Для того, чтобы Apache интерпретировал php и не предлагал сохранить php-файл
AddType application/x-httpd-php .php .phtml

## Установка кодировки UTF-8 по умолчанию
AddDefaultCharset UTF-8
EOF
# sudo a2enconf myconf
sudo mv my.conf /etc/apache2/conf-available
sudo a2enconf my
# sudo ln -s /etc/apache2/conf-available/myconf.conf /etc/apache2/conf-enabled/myconf.conf

sudo sh -c "sed -i '/memory_limit/s/128M/512M/' /etc/php5/apache2/php.ini"
sudo sh -c "sed -i '/post_max_size/s/8M/80M/' /etc/php5/apache2/php.ini"
sudo sh -c "sed -i '/upload_max_filesize/s/2M/2000M/' /etc/php5/apache2/php.ini"

sudo sh -c "sed -i '/memory_limit/s/128M/512M/' /etc/php5/cli/php.ini"
sudo sh -c "sed -i '/post_max_size/s/8M/80M/' /etc/php5/cli/php.ini"
sudo sh -c "sed -i '/upload_max_filesize/s/2M/2000M/' /etc/php5/cli/php.ini"

sudo php5enmod mcrypt
sudo a2enmod rewrite

sudo cat - > mailcatcher.${HOST_NAME}.conf <<EOF
<VirtualHost *:80>
    ServerName mailcatcher.${HOST_NAME}
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>
    ProxyRequests Off
    ProxyPassReverse / http://127.0.0.1:1080/
    ProxyPass / http://127.0.0.1:1080/
    ProxyPreserveHost Off
</VirtualHost>
EOF
sudo mv mailcatcher.${HOST_NAME}.conf /etc/apache2/sites-available
sudo a2ensite mailcatcher.${HOST_NAME}
# sudo ln -s /etc/apache2/sites-available/mailcatcher.${HOST_NAME}.conf /etc/apache2/sites-enabled/mailcatcher.${HOST_NAME}.conf
sudo a2enmod proxy proxy_http
# sudo a2enmod proxy_balancer

sudo apt-get -qq -y update
sudo service apache2 restart
