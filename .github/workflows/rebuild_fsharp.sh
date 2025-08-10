#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/fsharp

make
if [ $? -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-fsharp:latest fderepas/tal-fsharp:latest
        docker push fderepas/tal-fsharp:latest
    else
        printf \033[31mfsharp tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mfsharp docker build KO\033[0m"\n"
    exit 1
fi
