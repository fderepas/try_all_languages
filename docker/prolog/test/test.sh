#!/bin/bash
set -e
set -x
cat <<EOF > prog.prolog
main:- read_line_to_string(user_input,A),number_string(B,A),C is 1*B,writeln(C),read_line_to_string(user_input,D),writeln(D),read_line_to_string(user_input,E),writeln(E).
EOF
# code for eclipse prolog:
#main:- read_string(end_of_line, _, A),writeln(A),
#    read_string(end_of_line, _, B),writeln(B),
#    read_string(end_of_line, _, C),writeln(C).
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
       --name tal-prolog-$$ --rm \
       tal-prolog:latest /bin/sh /home/tal/launch.sh 9
for testcount in `seq 0 1 9`
do
    errc=`cat errcode$testcount.txt`
    if [ "$errc" -ne "0" ]; then
	printf "\033[31mwrong error code\033[0m";
	exit 1;
    fi
    cat out$testcount.txt | head -n 3 > out_compare$testcount.txt
    diff out$testcount.txt input$testcount.txt || errc=1
    if [ "$errc" -ne "0" ]; then
	set +x 
	printf "\033[31munexpected output in out$testcount.txt\033[0m";
	echo
	exit 1;
    fi
done

