#!/bin/bash
# build the docker image
set -x
set -e
cd `dirname $0` && docker pull alpine && docker pull ubuntu
docker build --rm --no-cache -t tal-$(basename `pwd`):`date +"%Y%m%d"`  -t tal-$(basename `pwd`):latest .


