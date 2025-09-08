#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/bqn

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-bqn:latest fderepas/tal-bqn:latest
        docker push fderepas/tal-bqn:latest
    else
        printf \033[31mbqn tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mbqn docker build KO\033[0m"\n"
    exit 1
fi
