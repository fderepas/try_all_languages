#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/cobol

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-cobol:latest fderepas/tal-cobol:latest
        docker push fderepas/tal-cobol:latest
    else
        printf \033[31mcobol tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mcobol docker build KO\033[0m"\n"
    exit 1
fi
