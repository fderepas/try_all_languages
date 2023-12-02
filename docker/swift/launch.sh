#!/bin/sh
# this script is to be run from a docker image
countNbTest=$1
set +e # support errors
cd
swiftc  /mnt/in/prog.swift
for testcount in `seq 0 1 $countNbTest`
do
    ./prog                                     \
                 < /mnt/in/input$testcount.txt \
                 > /mnt/out/out$testcount.txt  \
                 2> /mnt/out/err$testcount.txt
    echo $? > /mnt/out/errcode$testcount.txt
done
