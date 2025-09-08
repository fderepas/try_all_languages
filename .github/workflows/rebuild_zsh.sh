#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/zsh

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-zsh:latest fderepas/tal-zsh:latest
        docker push fderepas/tal-zsh:latest
    else
        printf \033[31mzsh tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mzsh docker build KO\033[0m"\n"
    exit 1
fi
