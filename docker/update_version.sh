#!/bin/bash
cd `dirname $0`
echo "{" > version.json
for i in `ls -F | grep / | tr -d '/'`; do
    cd $i
    v=`bash version.sh 2>&1 |  sed -e 's/\r/ /'|  sed -z 's/\n/ /g'|  sed -e 's/"/\\\\"/g'`
    cd ..
    echo "  \"$i\":\"$v\"," >> version.json
done
echo "}" >> version.json

