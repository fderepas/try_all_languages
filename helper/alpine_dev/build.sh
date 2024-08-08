#!/bin/bash
# build the docker image
set -x
set -e
cd `dirname $0` && docker pull alpine 
if [ ! -e execve_wrapper.c ]; then
    cp ../execve_wrapper.c .
fi
docker build --rm --no-cache -t tal_base_alpine_dev:latest .
docker tag tal_base_alpine_dev:latest fderepas/tal_base_alpine_dev:latest
docker push fderepas/tal_base_alpine_dev:latest


