#!/bin/sh
# this script is to be run from a docker image 
countNbTest=$1
cd /mnt
set +e # support errors
cd /home/tal/foo/src/App/
cp /mnt/in/prog.fs Program.fs
set +e
~/.dotnet/dotnet build 2>&1 > /mnt/out/err0.txt ||  exit 1
for testcount in `seq 0 1 $countNbTest`
do
    ~/.dotnet/dotnet run --no-build                 \
                      < /mnt/in/input$testcount.txt \
                      > /mnt/out/out$testcount.txt  \
                      2> /mnt/out/err$testcount.txt
    echo $? > /mnt/out/errcode$testcount.txt
done

