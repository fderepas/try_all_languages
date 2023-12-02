#!/bin/bash

dataFile=execution_time.json
echo "{" >  $dataFile
firstTime=1
for i in `docker images --format "{{.Repository}} {{.Tag}}" | grep ^tal- | grep latest | cut -d ' ' -f 1 | sort`; do
    j=`echo $i | cut -c5- `
    echo "$j"
    if [ $firstTime -eq 0 ]; then
        echo ",">> $dataFile
    fi
    cd $j/test
    a=$(/usr/bin/time  --format "%e"  make 2>&1 >/dev/null | tail -n 1)
    b=$(/usr/bin/time  --format "%e"  make 2>&1 >/dev/null | tail -n 1)
    c=$(/usr/bin/time  --format "%e"  make 2>&1 >/dev/null | tail -n 1)
    d=$(/usr/bin/time  --format "%e"  make 2>&1 >/dev/null | tail -n 1)
    cd ../..
    echo -e "\"$j\": [$a, $b, $c, $d]" >> $dataFile
    firstTime=0
done
echo "}" >>  $dataFile



