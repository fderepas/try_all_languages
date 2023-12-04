#!/bin/bash
set -e
set -x
cat <<EOF > prog.s
// https://en.wikibooks.org/wiki/X86_Assembly/GNU_assembly_syntax
// https://web.stanford.edu/class/cs107/resources/x86-64-reference.pdf
// this is the "main" function 
        .globl	main
main:
        // "subq Src, Dest" does "Dest = Dest − Src"
        // %rsp is the Stack pointer, we allocate 1008 bytes on the stack:
        // a buffer of size 1000 and and 8 byte int:
	subq	\$1008, %rsp
	movq	%fs:40, %rax
	movq	%rax, 1000(%rsp)
        // %rsi stores buffer to write to
	movq	%rsp, %rsi
.LOOP:
	movl	\$1000, %edx
        // set %edi to 0 (stdin)
        movl    \$0, %edi
        // perform read system call with arguments %edi %rsi %edx
	call	read@PLT
        // tests if %eax (return code) is zero or not.
	testl	%eax, %eax
        // if it is zero, no more data, go to .ENDLOOP
	jle	.ENDLOOP
        // move %eax (value returned by read) to %rdx 3rd argument of write
	movslq	%eax, %rdx
        // move value 1 (stdout) to register %edi
	movl	\$1, %edi
        // perform write system call with arguments %edi %rsp %rdx
	call	write@PLT
        // back to the beginnig of the loop
	jmp	.LOOP
.ENDLOOP:
	movq	1000(%rsp), %rax
	subq	%fs:40, %rax
        // we release the 1008 bytes previously allocated
	addq	\$1008, %rsp
	ret
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
       --name tal-assembly-$$ --rm \
       tal-assembly:latest /bin/sh /home/tal/launch.sh 9
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

