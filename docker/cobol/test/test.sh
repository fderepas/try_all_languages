#!/bin/bash
set -e
set -x
cat <<EOF > prog.cob
HELLO
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ADDITION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 NUM_1 PIC Z(10).
       01 WS-STR PIC X(20) VALUE ' '. 
       01 WS-SPACE PIC X(20).                       
       01 WS-FIELD PIC X(20).                       

       PROCEDURE DIVISION.
       PARA.
       ACCEPT NUM_1.
       MOVE NUM_1 TO WS-STR.
       UNSTRING WS-STR DELIMITED BY ALL SPACES INTO   
                WS-SPACE,WS-FIELD.   
       DISPLAY WS-FIELD.
       ACCEPT NUM_1.
       MOVE NUM_1 TO WS-STR.
       UNSTRING WS-STR DELIMITED BY ALL SPACES INTO   
                WS-SPACE,WS-FIELD.   
       DISPLAY WS-FIELD.
       ACCEPT NUM_1.
       MOVE NUM_1 TO WS-STR.
       UNSTRING WS-STR DELIMITED BY ALL SPACES INTO   
                WS-SPACE,WS-FIELD.   
       DISPLAY WS-FIELD.
       STOP RUN.
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
       --name tal-cobol-$$ --rm \
       tal-cobol:latest /bin/sh /home/tal/launch.sh 9
for testcount in `seq 0 1 9`
do
    errc=`cat errcode$testcount.txt`
    if [ "$errc" -ne "0" ]; then
	printf "\033[31mwrong error code\033[0m";
	exit 1;
    fi
    cat out$testcount.txt | head -n 3 | tr -d ' '> out_compare$testcount.txt
    diff out_compare$testcount.txt input$testcount.txt || errc=1
    if [ "$errc" -ne "0" ]; then
	set +x 
	printf "\033[31munexpected output in out$testcount.txt\033[0m";
	echo
	exit 1;
    fi
done

