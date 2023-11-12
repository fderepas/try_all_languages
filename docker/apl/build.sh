#!/bin/bash
# build the docker image
set -x
set -e
if [ -f apl.deb ]; then
    echo using file apl.deb
else
    wget -O apl.deb https://www.dyalog.com/uploads/php/download.dyalog.com/download.php?file=18.2/linux_64_18.2.45405_unicode.x86_64.deb 
fi
cd `dirname $0` && docker pull alpine && docker pull ubuntu
docker build --rm --no-cache -t tal-$(basename `pwd`):`date +"%Y%m%d"`  -t tal-$(basename `pwd`):latest .


