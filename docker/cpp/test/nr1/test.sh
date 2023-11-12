#!/bin/bash
set -e

cd `dirname $0`
curDir=`pwd`
testDir=`dirname $curDir`
dockerDir=`dirname $testDir`
lang=`basename $dockerDir`
i=0
while [ -e "input$i.txt" ]; do
    i=$[i+1]
done
imax=$[i-1]
echo $imax

set -x
docker run \
       --mount type=bind,source=`pwd`,target=/mnt/in,ro \
       --mount type=bind,source=`pwd`,target=/mnt/out \
       --network none \
       --name tal-$lang-$$ --rm \
       tal-$lang:latest /bin/sh /home/tal/launch.sh $imax
for testcount in `seq 0 1 $imax`
do
    errc=`cat errcode$testcount.txt`
    if [ "$errc" -ne "0" ]; then
	printf "\033[31mwrong error code\033[0m";
	exit 1;
    fi
    echo >> out$testcount.txt
    diff out$testcount.txt exp$testcount.txt || errc=1
    if [ "$errc" -ne "0" ]; then
	set +x 
	printf "\033[31munexpected output in out$testcount.txt\033[0m"
	echo
	exit 1
    fi
done
set +x
printf "\033[32mall $imax tests ok.\033[0m\n"

