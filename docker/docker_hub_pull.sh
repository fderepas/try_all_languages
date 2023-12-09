#!/bin/bash
cd `dirname $0`
function pull_from_docker() {
    i=$1
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
}
if [ "$#" -eq 0 ]; then
    for i in `ls -F | grep / | tr -d /`; do
	pull_from_docker $i
    done
fi
if [ "$#" -eq 1 ]; then
    pull_from_docker $1
fi
