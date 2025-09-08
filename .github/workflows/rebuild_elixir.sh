#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/elixir

make
if [ $? -eq 0 ]; then
    make test
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-elixir:latest fderepas/tal-elixir:latest
        docker push fderepas/tal-elixir:latest
    else
        printf \033[31melixir tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31melixir docker build KO\033[0m"\n"
    exit 1
fi
