#!/bin/sh
for i in `docker images | grep ^tal- | grep latest | cut -d ' ' -f 1 | sort`; do
    echo Saving image for $i
    docker save $i:latest | gzip > $i.tar.gz
done
