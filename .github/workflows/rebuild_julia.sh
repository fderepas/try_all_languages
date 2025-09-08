#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/julia

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-julia:latest fderepas/tal-julia:latest
        docker push fderepas/tal-julia:latest
    else
        printf \033[31mjulia tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mjulia docker build KO\033[0m"\n"
    exit 1
fi
