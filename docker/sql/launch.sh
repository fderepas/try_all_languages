#!/bin/sh
# this script is to be run from a docker image
/usr/bin/mariadbd-safe --datadir='/var/lib/mysql' --no-watch
sleep 8
countNbTest=$1
cd /mnt/in
set +e # support errors
# create an empty file
touch /home/tal/empty_file
# perform sql requests
for testcount in `seq 0 1 $countNbTest`
do
    echo 'delete from stdin' | mariadb tal
    echo 'delete from argv' | mariadb tal
    
    stdinData=/home/tal/empty_file
    if [ -e /mnt/in/input$testcount.txt ]; then
        stdinData=/mnt/in/input$testcount.txt
    fi
    argc=0
    if [ -e  /mnt/in/argc_${testcount}.txt ]; then
        argc=`cat /mnt/in/argc_${testcount}.txt`
    fi
    # populate table stdin
    counter=0
    while IFS= read -r line; do     # Read file line by line
        out="/tmp/foo.txt"
        echo "$line" | tr -d "\n" > "$out"
        echo "INSERT INTO stdin VALUES (${counter},LOAD_FILE('${out}'));" | mariadb tal
        # Increment counter for next file
        counter=$((counter + 1))
    done < "$stdinData"

    # populate table argv
    i=0
    while [ $i -lt $argc ]; do
        echo "INSERT INTO argv VALUES (${i},LOAD_FILE('/mnt/in/argv_"$testcount"_"$i".txt'));" | mariadb tal
        i=$((i + 1))
    done
    
    timeout -s 9 10                         \
        /usr/bin/mariadb                    \
            tal                             \
            -sN                             \
            < /mnt/in/prog.sql              \
            > /mnt/out/out$testcount.txt    \
            2> /mnt/out/err$testcount.txt
    echo $? > /mnt/out/errcode$testcount.txt
done
