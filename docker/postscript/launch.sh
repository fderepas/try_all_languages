#!/bin/sh
# this script is to be run from a docker image
countNbTest=$1
cd /mnt/in
set +e # support errors
for testcount in `seq 0 1 $countNbTest`
do
    timeout -s 9 10                       \
        gs  -q -dBATCH -dNOPAUSE prog.ps  \
            < input$testcount.txt         \
            > /mnt/out/out$testcount.txt  \
            2> /mnt/out/err$testcount.txt
    echo $? > /mnt/out/errcode$testcount.txt
done
