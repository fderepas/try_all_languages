#!/bin/bash
# build the docker image
set -x
set -e
cd `dirname $0` && docker pull alpine
if [ ! -e execve_wrapper.c ]; then
    cp ../execve_wrapper.c .
fi
#docker buildx create --use
#docker buildx build --platform=linux/amd64,linux/arm64 --rm --no-cache -t tal_base_alpine:latest .
docker build --rm --no-cache -t tal_base_alpine:latest .
docker tag tal_base_alpine:latest fderepas/tal_base_alpine:latest
docker push fderepas/tal_base_alpine:latest


