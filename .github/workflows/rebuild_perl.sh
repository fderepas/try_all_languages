#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/perl

make
if [ $? -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-perl:latest fderepas/tal-perl:latest
        docker push fderepas/tal-perl:latest
    else
        printf \033[31mperl tests \KO\033[0m"\n"
    fi
else
    printf \033[31mperl docker build KO\033[0m"\n"
    exit 1
fi
