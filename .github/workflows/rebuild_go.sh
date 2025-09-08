#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/go

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-go:latest fderepas/tal-go:latest
        docker push fderepas/tal-go:latest
    else
        printf \033[31mgo tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mgo docker build KO\033[0m"\n"
    exit 1
fi
