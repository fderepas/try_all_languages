#!/bin/bash
for i in `ls -F | grep / | grep -v ^erlang/$ | grep -v ^apl/$ | grep -v ^bqn/$ | grep -v ^dc/$ | grep -v haskell | grep -v clojure | grep -v kotlin | grep -v ^k/$ | grep -v ^r/$   `; do
    cd $i
    echo Building docker for $i
    make > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        cd test
        make > /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
            printf \\033[32mOK\\033[0m"\n"
        else
            printf \\033[31mtest_\KO\\033[0m"\n"
        fi
        cd ../.. 
    else
        printf \\033[31mKO\\033[0m"\n"
        cd ..
    fi
done
