#!/bin/bash
# build the docker image
set -x
set -e
cd `dirname $0` && docker pull alpine && docker pull ubuntu
GITHUB_UCONTENT_IP=`getent ahosts "release-assets.githubusercontent.com" | awk '{print $1; exit}'`
GITHUB_IP=`getent ahosts "github.com" | awk '{print $1; exit}'`
docker build --rm --no-cache --add-host="release-assets.githubusercontent.com:$GITHUB_UCONTENT_IP" --add-host="github.com:$GITHUB_IP" -t tal-$(basename `pwd`):`date +"%Y%m%d"`  -t tal-$(basename `pwd`):latest .


