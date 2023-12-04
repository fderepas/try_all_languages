#!/bin/sh
# this script is to be run from a docker image
countNbTest=$1
cd /home/tal/
set +e # support errors
#compile the code
gcc /mnt/in/prog.s \
    > /dev/null \
    2> /mnt/out/err0.txt \
    || exit 1
# run the code
for testcount in `seq 0 1 $countNbTest`
do
    timeout -s 9 10 /home/tal/a.out  \
            < /mnt/in/input$testcount.txt \
            > /mnt/out/out$testcount.txt  \
            2> /mnt/out/err$testcount.txt
    echo $? > /mnt/out/errcode$testcount.txt
done
