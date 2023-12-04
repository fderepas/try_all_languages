#!/bin/bash
cd `dirname $0`
for i in `ls -F | grep / | tr -d /`; do
    c=`docker images | grep "^tal-$i " | wc -l`
    echo $i
    docker pull fderepas/tal-$i:latest
    docker tag fderepas/tal-$i:latest tal-$i:latest
done
