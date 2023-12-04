#!/bin/bash
cd `dirname $0`
for i in `ls -F | grep / | tr -d /`; do
    c=`docker images | grep "^tal-$i " | wc -l`
    echo '**********************'
    echo pulling $i
    docker pull fderepas/tal-$i:latest
    docker tag fderepas/tal-$i:latest tal-$i:latest
    # now delete old image if any
    tag_to_keep=`docker images | grep "^tal-$i " | grep latest | tr -s ' ' | cut -d ' ' -f 3`
    for j in `docker images | grep "tal-$i " | grep -v $tag_to_keep | tr -s ' ' | cut -d ' ' -f 3`; do
	echo deleting $j
	docker rmi -f $j
    done
done
