#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/dc

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-dc:latest fderepas/tal-dc:latest
        docker push fderepas/tal-dc:latest
    else
        printf \033[31mdc tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mdc docker build KO\033[0m"\n"
    exit 1
fi
