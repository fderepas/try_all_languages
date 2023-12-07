#!/bin/bash
# this script is to be run from a docker image with
countNbTest=$1
cd /home/tal/
cp /mnt/in/prog.groovy .
set +e
for testcount in `seq 0 1 $countNbTest`
do
    /home/tal/.sdkman/candidates/groovy/current/bin/groovy prog.groovy \
         < /mnt/in/input$testcount.txt  \
         > /mnt/out/out$testcount.txt   \
         2> /mnt/out/err$testcount.txt
    echo $? > /mnt/out/errcode$testcount.txt
done
