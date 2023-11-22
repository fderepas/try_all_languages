#!/bin/bash
# build the docker image
set -x
set -e
cd `dirname $0` && docker pull nestybox/ubuntu-jammy-systemd-docker
bash generate_image_pull.sh > image_pull.sh
rm -rf rest_api_server
cp -r ../rest_api_server rest_api_server
docker build --rm --no-cache                     \
       -t tal_$(basename `pwd`):`date +"%Y%m%d"` \
       -t tal_$(basename `pwd`):latest .


