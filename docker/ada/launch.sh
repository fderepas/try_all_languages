#!/bin/sh
# this script is to be run from a docker image
countNbTest=$1
cd
cp /mnt/in/prog.adb .
set +e # support errors
#compile the code
gnatmake prog.adb \
    > /dev/null \
    2> /mnt/out/err0.txt \
    || exit 1
# run the code
for testcount in `seq 0 1 $countNbTest`
do
    timeout -s 9 10 /home/tal/prog  \
            < /mnt/in/input$testcount.txt \
            > /mnt/out/out$testcount.txt  \
            2> /mnt/out/err$testcount.txt
    echo $? > /mnt/out/errcode$testcount.txt
done
