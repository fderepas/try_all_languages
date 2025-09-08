#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/rust

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-rust:latest fderepas/tal-rust:latest
        docker push fderepas/tal-rust:latest
    else
        printf \033[31mrust tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mrust docker build KO\033[0m"\n"
    exit 1
fi
