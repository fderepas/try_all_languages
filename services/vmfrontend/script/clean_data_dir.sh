#!/bin/bash
#
set -x
set -e
cd `dirname $0`
cd ../data
for i in `find ./ -maxdepth 1 -type d -mtime +1 -print`; do
    rm -rf $i
done

