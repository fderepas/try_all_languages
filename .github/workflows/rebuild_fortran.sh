#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/fortran

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-fortran:latest fderepas/tal-fortran:latest
        docker push fderepas/tal-fortran:latest
    else
        printf \033[31mfortran tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mfortran docker build KO\033[0m"\n"
    exit 1
fi
