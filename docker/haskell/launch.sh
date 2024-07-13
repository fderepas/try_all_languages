#!/bin/sh
# this script is to be run from a docker image
countNbTest=$1
set +e # support errors
cd /home/tal
cp /mnt/in/prog.hs .
/usr/bin/ghc prog.hs  > /dev/null 2> /mnt/out/err0.txt || exit 1
cd /mnt
for testcount in `seq 0 1 $countNbTest`
do
    /home/tal/prog               \
        < /mnt/in/input$testcount.txt \
        > /mnt/out/out$testcount.txt  \
        2> /mnt/out/err$testcount.txt
    echo $? > /mnt/out/errcode$testcount.txt
done

