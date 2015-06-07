#!/usr/bin/env bash

echo "------------------------------"
echo "composer"
echo "------------------------------"

curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

composer config -g github-oauth.github.com $1