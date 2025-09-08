#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/powershell

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-powershell:latest fderepas/tal-powershell:latest
        docker push fderepas/tal-powershell:latest
    else
        printf \033[31mpowershell tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mpowershell docker build KO\033[0m"\n"
    exit 1
fi
