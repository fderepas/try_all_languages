#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/typescript

make
if [ $? -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-typescript:latest fderepas/tal-typescript:latest
        docker push fderepas/tal-typescript:latest
    else
        printf \033[31mtypescript tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mtypescript docker build KO\033[0m"\n"
    exit 1
fi
