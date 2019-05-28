#!/bin/sh

sudo echo "localhost" > /etc/hostname
sudo rm /etc/resolv.conf
sudo echo "nameserver 1.1.1.1" > /etc/resolv.conf

sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
