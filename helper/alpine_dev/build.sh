#!/bin/bash
# build the docker image
set -x
set -e
cd `dirname $0` && docker pull alpine 
docker build --rm --no-cache -t tal_base_alpine_dev:latest .
docker tag tal_base_alpine_dev:latest fderepas/tal_base_alpine_dev:latest
docker push fderepas/tal_base_alpine_dev:latest


