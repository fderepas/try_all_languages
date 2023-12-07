#!/bin/bash
cd `dirname $0`
if [ "$#" -eq 0 ]; then
    for i in `ls -F | grep / | tr -d /`; do
        echo '**************************'
        echo $i
        echo '**************************'
        docker tag tal-$i:latest fderepas/tal-$i:latest
        docker push fderepas/tal-$i:latest
    done
fi
if [ "$#" -eq 1 ]; then
    i=$1
    docker tag tal-$i:latest fderepas/tal-$i:latest
    docker push fderepas/tal-$i:latest
fi
