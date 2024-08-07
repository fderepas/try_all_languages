#!/bin/bash
# build the docker image
set -x
set -e
if [ `docker images | grep tal_base_alpine | wc -l` -eq 0 ]; then
    # create the tal_base_alpine docker image
    cd `dirname $0`
    cd ../../helper/alpine
    make
fi
cd `dirname $0`
docker build --rm --no-cache -t tal-$(basename `pwd`):`date +"%Y%m%d"`  -t tal-$(basename `pwd`):latest .


