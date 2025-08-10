#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/logo

make
if [ $? -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-logo:latest fderepas/tal-logo:latest
        docker push fderepas/tal-logo:latest
    else
        printf \033[31mlogo tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mlogo docker build KO\033[0m"\n"
    exit 1
fi
