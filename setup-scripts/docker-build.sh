#!/bin/sh

sudo docker rm -f evilginx2

sudo docker build /opt/evilginx2 -t evilginx2
