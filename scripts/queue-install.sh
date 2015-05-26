#!/usr/bin/env bash

echo "------------------------------"
echo "queues: beanstalkd, supervisord"
echo "------------------------------"

sudo apt-get -qq -y update
sudo apt-get -y install beanstalkd > /dev/null
sudo service beanstalkd restart

sudo apt-get -y install supervisor > /dev/null

sudo supervisorctl reread > /dev/null
sudo supervisorctl update > /dev/null
sudo service supervisor restart > /dev/null
