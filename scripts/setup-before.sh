#!/usr/bin/env bash
echo "------------------------------"
echo "install environment"
echo "------------------------------"
for i in 5 4 3 2 1
do
echo "$i"
sleep 1
done

echo "------------------------------"
echo "updating"
echo "------------------------------"
sudo apt-get -qq -y update

echo "------------------------------"
echo "mc curl nmap htop ssh openssh-server git-core zip"
echo "------------------------------"

sudo sh -c "sed -i 's/# set const/set const/' /etc/nanorc"
sudo apt-get -y install mc curl nmap htop ssh openssh-server git-core zip > /dev/null
sudo apt-get -qq -y update