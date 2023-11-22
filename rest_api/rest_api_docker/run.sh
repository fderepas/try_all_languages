#!/bin/sh
docker run --runtime=sysbox-runc -it -p 8087:8087  --mount type=bind,source=`pwd`/docker-registry/,target=/mnt/images,ro tal_$(basename `pwd`):latest
