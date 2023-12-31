#!/bin/bash
set -e
set -x
pkgName=sysbox-ce_0.6.2-0.linux_amd64.deb
wget https://downloads.nestybox.com/sysbox/releases/v0.6.2/$pkgName
docker rm $(docker ps -a -q) -f || echo "no docker container running."
sudo apt-get install jq -y
sudo apt-get install ./$pkgName -y
rm $pkgName
sudo systemctl status sysbox -n20

