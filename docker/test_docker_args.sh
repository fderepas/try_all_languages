#!/bin/bash
# test a docker by running a simple program which takes 3 numbers as an input
# and outputs the same numbers.
# Use arguments on the command line and not standard input to read
# numbers
set -e
set -x
if [ "$#" -ne 1 ]; then
    echo "indicate the name of the language to test." 1>&2
    exit 1
fi
cd `dirname $0`
lang=$1
sourcefile=prog.`bash ../rest_api/rest_api_server/public/get_ext.sh $lang`
bash ../rest_api/rest_api_server/public/get_code_args.sh $lang > $lang/test_args/$sourcefile
cd $lang/test_args/
r1=()
r2=()
r3=()
for testcount in `seq 0 1 9`
do
    r1[$testcount]=$RANDOM
    r2[$testcount]=$RANDOM
    r3[$testcount]=$RANDOM
    printf ${r1[$testcount]} > argv_${testcount}_0.txt
    printf ${r2[$testcount]} >> argv_${testcount}_1.txt
    printf ${r3[$testcount]} >> argv_${testcount}_2.txt
    printf 3 >  argc_${testcount}.txt
done
docker run \
       --mount type=bind,source=`pwd`,target=/mnt/in,ro \
       --mount type=bind,source=`pwd`,target=/mnt/out \
       --network none \
       --name tal-$lang-$$ --rm \
       tal-$lang:latest /bin/sh /home/tal/launch.sh 9
for testcount in `seq 0 1 9`
do
    errc=`cat errcode$testcount.txt`
    if [ "$errc" -ne "0" ]; then
	printf "\033[31mwrong error code\033[0m";
	exit 1;
    fi
    echo `cat argv_${testcount}_0.txt` > expected_$testcount.txt
    echo `cat argv_${testcount}_1.txt` >> expected_$testcount.txt
    echo `cat argv_${testcount}_2.txt` >> expected_$testcount.txt
    cat out$testcount.txt | head -n 3 | sed -e 's/ *$//' > out_head$testcount.txt
    diff out_head$testcount.txt expected_$testcount.txt || errc=1
    if [ "$errc" -ne "0" ]; then
	set +x 
	printf "\033[31mUnexpected output in out$testcount.txt expected expected_$testcount.txt instead.\033[0m";
	echo
	exit 1;
    fi
done

