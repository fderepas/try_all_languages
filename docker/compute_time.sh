#!/bin/bash
cd `dirname $0`
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
    for i in `seq 1 10`; do
        a+=", "$(/usr/bin/time  --format "%e"  make 2>&1 >/dev/null | tail -n 1)
    done
    cd ../..
    echo -e "\"$j\": [$a]" >> $dataFile
    firstTime=0
done
echo "}" >>  $dataFile



