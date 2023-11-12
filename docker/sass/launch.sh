#!/bin/sh
# This script is to be run from a docker image 
countNbTest=$1
cd /home/tal
set +e # support errors

# Import all the built-in functions.
# They can be found at:
# https://github.com/aderepas/WeekGolf
touch ~/prog.scss
touch ~/prog_temp.scss


# Add user data
cat /mnt/in/prog.scss >> ~/prog.scss
for testcount in `seq 0 1 $countNbTest`
do
    # Copy stdin to a file named 'toto'
    cp /mnt/in/input$testcount.txt toto
    echo -n '";' >> toto; # Closing the STDIN

    # Insert the STDIN
    echo -n '$STDIN: "' >> prog_temp.scss # Declare the variable STDIN
    sed -E ':a;N;$!ba;s/\r{0,1}\n/\\a /g' toto >> prog_temp.scss  # Replace \n by \\a[SPACE]

    # Insert the built-in functions
    cat ~/functions.scss >> ~/prog_temp.scss
    # Program of the user
    cat ~/prog.scss >> ~/prog_temp.scss


    # Calling sass
    #sass ~/prog_temp.scss | sed -r 's/prog_temp\.scss\:[0-9]+\sDEBUG:\s//g' > /mnt/out/out$testcount.txt 2> /mnt/out/err$testcount.txt
    touch STDOUT
	#    touch STDERR
 #echo 'DEBUGGING:'
    sass ~/prog_temp.scss &> STDOUT
    stdout=""
    i=1
    len=$(wc -l STDOUT | awk '{ print $1 }')
    while read line; do
        test=$(echo "$line" | sed -r 's/prog_temp\.scss\:[0-9]+\sDEBUG:\s//g')
	if [ $i == $((len)) ]; then
		stdout="$stdout$test"
		#echo "Print debug:\n"
		#echo $i
		#echo $len
	else
		stdout="$stdout$test\n"
	fi
    	i=$((i+1))
    done <STDOUT
    #stdout=${stdout::-2}
    echo -e "$stdout"  > /mnt/out/out$testcount.txt
    echo -e "\n" > /mnt/out/err$testcount.txt
    #cat /mnt/out/out$testcount.txt
    #echo $(cat /mnt/out/out$testcount.txt) | sed -r 's/prog_temp\.scss\:[0-9]+[[:space:]]DEBUG:[[:space:]]//g' > /mnt/out/out$testcount.txt
    #cat /mnt/out/out$testcount.txt | sed -r 's/prog//g' > /mnt/out/out$testcount.txt
    #cat /mnt/out/err$testcount.txt | sed -r 's/prog_temp\.scss\:[0-9]+\sDEBUG:\s//g' > /mnt/out/err$testcount.txt
    #cat /mnt/out/out$testcount.txt
    rm STDOUT
    #rm STDERR

    # Get stderr
    echo $? > /mnt/out/errcode$testcount.txt

    > ~/prog_temp.scss
done

rm ~/prog_temp.scss
rm ~/prog.scss
