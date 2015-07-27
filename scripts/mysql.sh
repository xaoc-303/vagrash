#!/usr/bin/env bash

echo "------------------------------"
echo "mysql"
echo "------------------------------"

USER_PASS=$1
USER_BASE=$2
IS_REMOTE=$3

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $USER_PASS"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $USER_PASS"

# install mysql-server-5.5 mysql-client-5.5
sudo apt-get -y install mysql-server > /dev/null
sudo apt-get -qq -y update

sudo sed -i '22idefault-character-set=utf8' /etc/mysql/my.cnf
sudo sed -i "111iskip-character-set-client-handshake" /etc/mysql/my.cnf
sudo sed -i "111icharacter-set-server = utf8" /etc/mysql/my.cnf
sudo sed -i "111iinit-connect='SET NAMES utf8'" /etc/mysql/my.cnf
sudo sed -i "111icollation-server=utf8_general_ci" /etc/mysql/my.cnf
sudo sed -i '121idefault-character-set=utf8' /etc/mysql/my.cnf

sudo sh -c "sed -i '/key_buffer/s/16M/160M/g' /etc/mysql/my.cnf"
sudo sh -c "sed -i '/max_allowed_packet/s/16M/160M/g' /etc/mysql/my.cnf"
sudo sh -c "sed -i '/thread_stack/s/192K/1920K/' /etc/mysql/my.cnf"

if [ $IS_REMOTE == "true" ]; then

sudo sh -c "sed -i '/bind-address/s/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf"

MYSQL=`which mysql`

Q1="GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$1' WITH GRANT OPTION;"
Q2="FLUSH PRIVILEGES;"
Q3="CREATE DATABASE IF NOT EXISTS $USER_BASE"
SQL="${Q1}${Q2}${Q3}"

$MYSQL -uroot -p$1 -e "$SQL"

sudo service mysql restart

fi