#!/bin/bash
cd `dirname $0`
cd ..
cd data
docker kill `docker ps --format="{{.RunningFor}} {{.Names}}" | grep tal- | grep minutes | awk -F: '{if($1>2)print$1}'  | awk ' {print $4} '` 2> /dev/null
#find . -ctime +30 -exec rm -rf '{}' ';

