#!/usr/bin/env bash

echo "------------------------------"
echo "apache vhost"
echo "------------------------------"

HOST_NAME=$1
DOMAIN=$2

sudo cat - > ${DOMAIN}.conf <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/${HOST_NAME}/public"
    ServerName ${DOMAIN}
    Options Indexes FollowSymLinks
    <Directory "/var/www/${HOST_NAME}/public/">
        AllowOverride All
        Order Deny,Allow
        #Deny from all
        #Allow from 127.0.0.1
        Allow from All
        Require all granted
        #If you want to allow access from your internal network
        # For specific ip addresses add one line per ip address
        #Allow from 192.168.0.100
        # For every ip in the subnet, just use the first 3 numbers of the subnet
        #Allow from 192.168.0
    </Directory>
</VirtualHost>
EOF
sudo mv ${DOMAIN}.conf /etc/apache2/sites-available
sudo a2ensite ${DOMAIN}
# sudo ln -s /etc/apache2/sites-available/${HOST_NAME}.conf /etc/apache2/sites-enabled/${HOST_NAME}.conf

sudo service apache2 restart
