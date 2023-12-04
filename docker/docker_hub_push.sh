#!/bin/bash
cd `dirname $0`
for i in `ls -F | grep / | tr -d /`; do
    c=`docker images | grep "^tal-$i " | wc -l`
    if (( c > 1 )); then
	echo '**************************'
        echo $i
	echo '**************************'
	tag_to_keep=`docker images | grep "^tal-$i " | grep latest | tr -s ' ' | cut -d ' ' -f 3`
        imageData=`docker images | grep "$tag_to_keep" | grep -v latest | tr -s ' ' | cut -d ' ' -f 2`
        docker tag tal-$i:$imageData fderepas/tal-$i:$imageData
        docker tag tal-$i:$imageData fderepas/tal-$i:latest
        docker push fderepas/tal-$i:$imageData
        docker push fderepas/tal-$i:latest
    fi
done
