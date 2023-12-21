#!/bin/bash
# build the docker image
set -x
set -e
cd `dirname $0` && docker pull alpine 
docker build --rm --no-cache -t tal_base_alpine:latest .


