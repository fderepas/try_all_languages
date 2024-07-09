#!/bin/bash
cd `dirname $0`
echo "{" > version.json
for i in `ls -F | grep / | tr -d '/'`; do
    cd $i
    v=`bash version.sh 2>&1 || echo error`
    w=`echo "$v" | tr -d '\r'`
    cd ..
    echo "\"$i\":\"$w\"," >> version.json
done
echo "}" >> version.json

