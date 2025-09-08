#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/vyxal

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-vyxal:latest fderepas/tal-vyxal:latest
        docker push fderepas/tal-vyxal:latest
    else
        printf \033[31mvyxal tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mvyxal docker build KO\033[0m"\n"
    exit 1
fi
