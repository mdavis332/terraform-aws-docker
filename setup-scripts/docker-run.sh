#!/bin/sh 

sudo docker run \
	-d  \
	-p 443:443 -p 80:80 -p 53:53/udp \
	-v /opt/evilginx2/phishlets:/app/phishlets:ro \
	evilginx2
