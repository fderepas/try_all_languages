#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/golfscript

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-golfscript:latest fderepas/tal-golfscript:latest
        docker push fderepas/tal-golfscript:latest
    else
        printf \033[31mgolfscript tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mgolfscript docker build KO\033[0m"\n"
    exit 1
fi
