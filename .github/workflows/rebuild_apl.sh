#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/apl

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-apl:latest fderepas/tal-apl:latest
        docker push fderepas/tal-apl:latest
    else
        printf \033[31mapl tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mapl docker build KO\033[0m"\n"
    exit 1
fi
