#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/fig

make
if [ $? -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-fig:latest fderepas/tal-fig:latest
        docker push fderepas/tal-fig:latest
    else
        printf \033[31mfig tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mfig docker build KO\033[0m"\n"
    exit 1
fi
