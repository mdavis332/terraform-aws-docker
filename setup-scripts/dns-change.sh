#!/bin/sh

echo 'localhost' | sudo tee /etc/hostname
# remove resolv.conf first since it's usually a symlink rather than a file
sudo rm /etc/resolv.conf
echo 'nameserver 1.1.1.1' | sudo tee /etc/resolv.conf

sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
