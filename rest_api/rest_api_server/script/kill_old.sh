#!/bin/bash
set -e
cd `dirname $0`
cd ..
cd data
# kill dockers starting with 'tal-' who are still running for more than 2 minutes
docker kill `docker ps --format="{{.RunningFor}} {{.Names}}" | grep tal- | grep minutes | awk -F: '{if($1>2)print$1}'  | awk ' {print $4} '` 2> /dev/null
# remove data dir older that 2 minutes 
find . -maxdepth 1 -type d -mmin +2 -exec rm -rf {} \;

