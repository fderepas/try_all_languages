#!/bin/bash
cd `dirname $0`
for i in `ls -F | grep / | tr -d /`; do
    c=`docker images | grep "^tal-$i " | wc -l`
    if (( c > 1 )); then
	echo '**************************'
        echo $i
	echo '**************************'
	tag_to_keep=`docker images | grep "^tal-$i " | grep latest | tr -s ' ' | cut -d ' ' -f 3`
        docker tag tal-$i:latest fderepas/tal-$i:latest
        docker push fderepas/tal-$i:latest
    fi
done
