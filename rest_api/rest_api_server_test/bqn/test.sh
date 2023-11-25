cat <<EOF > program.txt
•Out¨ •args
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

