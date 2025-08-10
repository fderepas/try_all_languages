#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/ruby

make
if [ $? -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-ruby:latest fderepas/tal-ruby:latest
        docker push fderepas/tal-ruby:latest
    else
        printf \033[31mruby tests \KO\033[0m"\n"
        exit 2
    fi
else
    printf \033[31mruby docker build KO\033[0m"\n"
    exit 1
fi
