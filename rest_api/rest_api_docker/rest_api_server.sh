#!/bin/sh
hostIp=`/sbin/ip route|awk '/default/ { print $3 }'`
echo "$hostIp talhost" >> /etc/hosts
/bin/sh /home/admin/image_pull.sh > /home/admin/image_pull.log 2>/home/admin/image_pull.err

