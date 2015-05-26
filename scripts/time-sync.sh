#!/usr/bin/env bash

# sudo apt-get -y install ntp ntpdate
sudo aptitude install ntp -y > /dev/null
sudo apt-get -qq -y update
echo 'echo "# You do need to talk to an NTP server or two (or three)." >> /etc/ntp.conf' | sudo -s
echo 'echo "server ntp0.zenon.net" >> /etc/ntp.conf' | sudo -s
echo 'echo "server time.nist.gov" >> /etc/ntp.conf' | sudo -s
echo 'echo "server ntp.ubuntu.com" >> /etc/ntp.conf' | sudo -s
sudo service ntp restart