#!/usr/bin/env bash

echo "------------------------------"
echo "postgresql"
echo "------------------------------"

POSTGRE_VERSION=9.3

USER_PASS=$1
USER_BASE=$2
IS_REMOTE=$3

sudo apt-get -y install postgresql postgresql-contrib > /dev/null
sudo apt-get -qq -y update

sudo service postgresql stop
sudo /usr/bin/pg_dropcluster --stop $POSTGRE_VERSION main
sudo /usr/bin/pg_createcluster --locale ru_RU.UTF-8 --start $POSTGRE_VERSION main

if [ $IS_REMOTE == "true" ]; then

sudo sh -c "sed -i '/listen_addresses/s/localhost/0.0.0.0/g' /etc/postgresql/$POSTGRE_VERSION/main/postgresql.conf"
sudo sh -c "sed -i '/listen_addresses/s/#listen/listen/g' /etc/postgresql/$POSTGRE_VERSION/main/postgresql.conf"

sudo sh -c "sed -i '/local   all/s/local/#local/' /etc/postgresql/$POSTGRE_VERSION/main/pg_hba.conf"
sudo sh -c "sed -i '/host    all/s/host/#host/' /etc/postgresql/$POSTGRE_VERSION/main/pg_hba.conf"
echo "echo 'local   all             all                                     md5' >> /etc/postgresql/$POSTGRE_VERSION/main/pg_hba.conf" | sudo -s
echo "echo 'host    all             all             127.0.0.1/32            md5' >> /etc/postgresql/$POSTGRE_VERSION/main/pg_hba.conf" | sudo -s
echo "echo 'host    all             all             10.0.0.0/16             md5' >> /etc/postgresql/$POSTGRE_VERSION/main/pg_hba.conf" | sudo -s

fi

sudo service postgresql start

# sudo -u postgres createuser -s vagrant
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$USER_PASS';"
sudo -u postgres psql -c "CREATE ROLE root LOGIN ENCRYPTED PASSWORD '$USER_PASS' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"

# sudo -u postgres psql -c "CREATE DATABASE $USER_BASE WITH OWNER = postgres ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8' TEMPLATE = template0 CONNECTION LIMIT = -1;"
sudo -u postgres psql -c "CREATE DATABASE $USER_BASE ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8' TEMPLATE = template0 CONNECTION LIMIT = -1;"
sudo -u postgres psql -d $USER_BASE -c "CREATE EXTENSION hstore SCHEMA public;"
sudo -u postgres psql -l
sudo -u postgres psql -c "SELECT * FROM pg_shadow;"

sudo service postgresql restart