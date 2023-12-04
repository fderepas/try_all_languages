cat <<EOF > program.txt
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
data=""
for testcount in `seq 0 1 9`
do
    r1[$testcount]=$RANDOM
    r2[$testcount]=$RANDOM
    r3[$testcount]=$RANDOM
    echo ${r1[$testcount]} > input$testcount.txt
    echo ${r2[$testcount]} >> input$testcount.txt
    echo ${r3[$testcount]} >> input$testcount.txt
    node -e 'console.log(encodeURIComponent(require("fs").readFileSync(0).toString()));' < input$testcount.txt > input$testcount.enc
    data=$data"&input$testcount="`cat input$testcount.enc`
#rm input.txt
done

node -e 'console.log(encodeURIComponent(require("fs").readFileSync(0).toString()));' < program.txt > program.enc
#rm program.txt
lang=`basename $PWD`
wget -O index.json "$1/?lang=$lang&countInput=10$data"'&code='`cat program.enc` 

for i in `seq 0 1 9`
do
    node -e 'console.log(decodeURIComponent(JSON.parse(require("fs").readFileSync("index.json")).data['$i'].out))' | head -n 3 > out$i.txt
    errc=0
    diff out$i.txt input$i.txt || errc=1
    if [ "$errc" -ne "0" ]; then
	set +x 
	printf "\033[31munexpected out$i\033[0m";
	echo
	exit 1;
    fi

done

