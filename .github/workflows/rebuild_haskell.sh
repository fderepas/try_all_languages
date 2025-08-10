#!/bin/bash
set -e
set -x
cd `dirname $0`
cd ../../docker/haskell
make
if [ 0 -eq 0 ]; then
    make test > /dev/null 2> /dev/null
    if [ 0 -eq 0 ]; then
        printf \033[32mOK\033[0m"\n"
        push_to_registry  fderepas latest
    else
        printf \033[31mhaskell test_\KO\033[0m"\n"
    fi
else
    printf \033[31mhaskell KO\033[0m"\n"
    exit 1
fi
