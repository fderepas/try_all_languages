#!/bin/bash
# build the docker image
set -x
set -e
cd `dirname $0` && docker pull ubuntu
if [ ! -e execve_wrapper.c ]; then
    cp ../execve_wrapper.c .
fi
docker build --rm --no-cache -t tal_base_ubuntu:latest .
docker tag tal_base_ubuntu:latest fderepas/tal_base_ubuntu:latest
docker push fderepas/tal_base_ubuntu:latest


