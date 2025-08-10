#!/bin/bash
set -e
set -x

cd `dirname $0`
cd ../../docker/clojure

make
if [ $? -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        docker tag tal-clojure:latest fderepas/tal-clojure:latest
        docker push fderepas/tal-clojure:latest
    else
        printf \033[31mclojure tests \KO\033[0m"\n"
    fi
else
    printf \033[31mclojure docker build KO\033[0m"\n"
    exit 1
fi
