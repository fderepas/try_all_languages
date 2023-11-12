#!/bin/bash
for i in `ls -F | grep / | tr -d /`; do
    c=`docker images | grep "tal-$i " | wc -l`
    if (( c > 1 )); then
	echo $i
	tag_to_keep=`docker images | grep "tal-$i " | grep latest | tr -s ' ' | cut -d ' ' -f 3`
	for j in `docker images | grep "tal-$i " | grep -v $tag_to_keep | tr -s ' ' | cut -d ' ' -f 3`; do
	    docker rmi $j
	done
    fi
done
