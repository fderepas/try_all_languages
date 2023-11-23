#!/bin/sh
# this script is to be run from a docker image 
countNbTest=$1
cd
set +e # support errors
export PATH=/home/tal/erlang/bin:$PATH
cp /mnt/in/prog.erl .
/home/tal/erlang/bin/erlc prog.erl > /mnt/out/out0.txt  \
                                   2> /mnt/out/err0.txt
if [ $? -eq 0 ]; then
    # compilation is ok
    for testcount in `seq 0 1 $countNbTest`
    do
        /home/tal/erlang/bin/erl -noshell -s prog start -s init stop \
               < /mnt/in/input$testcount.txt \
               > /mnt/out/out$testcount.txt  \
               2> /mnt/out/err$testcount.txt
        echo $? > /mnt/out/errcode$testcount.txt
    done
fi
