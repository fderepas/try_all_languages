#!/bin/bash
cd `dirname $0`
islaunched=`pm2 status | grep 0 | grep index | wc -l`
if [ $islaunched -eq "0" ]; then
    cd ../
    make
fi
