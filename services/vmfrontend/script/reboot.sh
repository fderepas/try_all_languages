#!/bin/bash
set -e
num=`cat /etc/hostname | sed -e 's/vmback\([0-9]*\)/\1/g'`
isvmback=`cat /etc/hostname | grep vmback | wc -l`
delay=$((num * 600))
if [ $isvmback -ne "0" ]; then
    sleep $delay
    pm2 stop 0
    sleep 2
    sudo shutdown -r now
fi
