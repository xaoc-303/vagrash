#!/usr/bin/env bash

HOST_NAME=$1

echo "------------------------------"
echo "other"
echo "------------------------------"

# sudo netstat -tlpnu | grep :1025
sudo netstat -anltp | grep "LISTEN"
# sudo nmap -O 127.0.0.1

date
sudo hwclock --show

echo "------------------------------"
