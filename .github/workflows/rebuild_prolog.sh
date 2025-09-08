#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/prolog

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-prolog:latest fderepas/tal-prolog:latest
        docker push fderepas/tal-prolog:latest
    else
        printf \033[31mprolog tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mprolog docker build KO\033[0m"\n"
    exit 1
fi
