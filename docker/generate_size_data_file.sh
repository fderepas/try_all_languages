#!/bin/bash
dataFile=image_size.json
echo "{" >  $dataFile
firstTime=1
for i in `docker images --format "{{.Repository}} {{.Tag}}" | grep ^tal- | grep latest | cut -d ' ' -f 1`; do
    if [ $firstTime -eq 0 ]; then
        echo ",">> $dataFile
    fi
    echo -e "\"`echo $i | cut -c5- `\":`docker inspect ${i}:latest | jq '.[].Size'`" >> $dataFile
    firstTime=0
done
echo "}" >>  $dataFile
