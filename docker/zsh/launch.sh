#!/bin/sh
# this script is to be run from a docker image
countNbTest=$1
cd /mnt/in
set +e # support errors
# create an empty file
touch /home/tal/empty_file
# run the script
for testcount in `seq 0 1 $countNbTest`
do
    stdinData=/home/tal/empty_file
    if [ -e /mnt/in/input$testcount.txt ]; then
        stdinData=/mnt/in/input$testcount.txt
    fi
    argc=0
    if [ -e  /mnt/in/argc_${testcount}.txt ]; then
        argc=`cat /mnt/in/argc_${testcount}.txt`
    fi
    # call 'a.out' through timeout and execve_wrapper
    # argv in /in/argv_${testcount}_*
    # stdin in /mnt/in/input$testcount.txt
    timeout -s 9 10                         \
        /home/tal/execve_wrapper            \
            /mnt/in/argv_${testcount}_      \
            $argc                           \
            /bin/zsh /mnt/in/prog.zsh       \
         < $stdinData                       \
         > /mnt/out/out$testcount.txt       \
         2> /mnt/out/err$testcount.txt
    echo $? > /mnt/out/errcode$testcount.txt
done



