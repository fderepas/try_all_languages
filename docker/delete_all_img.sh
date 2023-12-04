#!/bin/bash
img=`docker images | grep tal- | tr -s ' ' | cut -d ' ' -f 3`
if [ "$img" == "" ]; then
    echo no image to delete
else
    docker rmi -f $img
fi
docker system prune -f
