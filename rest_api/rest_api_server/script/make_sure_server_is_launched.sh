#!/bin/bash
cd `dirname $0`
cd ..
islaunched=`make status | grep 0 | grep index | wc -l`
if [ $islaunched -eq "0" ]; then
    make
fi
