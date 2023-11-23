#!/bin/bash
set -e
set -x
cat <<EOF > prog.erl
-module(prog).
-export([start/0]).
start() ->
    hello(3).

%% Do nothing when there is no hello to write
hello(N) when N =< 0 -> ok;
%% Else, write a 'Hello World!', and then write (n-1) hellos
hello(N) ->
   Line = io:get_line(""),
   io:format(Line),
   hello(N - 1).
EOF
r1=()
r2=()
r3=()
for testcount in `seq 0 1 9`
do
    r1[$testcount]=$RANDOM
    r2[$testcount]=$RANDOM
    r3[$testcount]=$RANDOM
    echo ${r1[$testcount]} > input$testcount.txt
    echo ${r2[$testcount]} >> input$testcount.txt
    echo ${r3[$testcount]} >> input$testcount.txt
done
docker run \
       --mount type=bind,source=`pwd`,target=/mnt/in,ro \
       --mount type=bind,source=`pwd`,target=/mnt/out \
       --network none \
       --name tal-erlang-$$ --rm \
       tal-erlang:latest /bin/sh /home/tal/launch.sh 9
for testcount in `seq 0 1 9`
do
    errc=`cat errcode$testcount.txt`
    if [ "$errc" -ne "0" ]; then
	printf "\033[31mwrong error code\033[0m";
	exit 1;
    fi
    diff out$testcount.txt input$testcount.txt || errc=1
    if [ "$errc" -ne "0" ]; then
	set +x 
	printf "\033[31munexpected output in out$testcount.txt\033[0m";
	echo
	exit 1;
    fi
done

