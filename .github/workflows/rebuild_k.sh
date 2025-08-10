#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/k

make
if [ $? -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-k:latest fderepas/tal-k:latest
        docker push fderepas/tal-k:latest
    else
        printf \033[31mk tests \KO\033[0m"\n"
    fi
else
    printf \033[31mk docker build KO\033[0m"\n"
    exit 1
fi
