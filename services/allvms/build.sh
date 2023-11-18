#!/bin/bash
# build the docker image
set -x
set -e
cd `dirname $0` && docker pull nestybox/ubuntu-jammy-systemd-docker
bash generate_image_pull.sh > image_pull.sh
docker build --rm --no-cache -t tal-$(basename `pwd`):`date +"%Y%m%d"`  -t tal-$(basename `pwd`):latest .


