#!/bin/sh
for i in `docker images | grep ^tal- | grep latest | cut -d ' ' -f 1 | grep -v  tal-allvms | sort`; do
    echo Saving image for $i
    docker save $i | gzip > $i.tar.gz
done
