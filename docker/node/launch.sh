#!/bin/sh
# this script is to be run from a docker image 
countNbTest=$1
cd /home/tal
set +e # support errors

# Provide the 'prompt' wrapper function, to read stdin.
# Stdin is expected to be found in a function named 'toto'.
# Made the name of the array longer because othewise it could
# be faster direcly access the array.
cat <<EOF > ~/prog.js
var tal_arr_congrats_for_finding_the_name_of_this_array__I_made_it_a_little_longer_so_that_it_is_less_useful_ = require('fs').readFileSync('toto').toString().split("\n");
let tal_arr_count=0;

function prompt() {
    if (tal_arr_count>=tal_arr_congrats_for_finding_the_name_of_this_array__I_made_it_a_little_longer_so_that_it_is_less_useful_.length) return undefined;
    tal_arr_count++;
    return tal_arr_congrats_for_finding_the_name_of_this_array__I_made_it_a_little_longer_so_that_it_is_less_useful_[tal_arr_count-1];
}
EOF
# add user data
cat /mnt/in/prog.js >> ~/prog.js
# create an empty file
touch /home/tal/empty_file
# run the code
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

    # copy stdin to a file named 'toto'
    cp $stdinData toto
    # call nodejs 
    /home/tal/execve_wrapper              \
        /mnt/in/argv_${testcount}_        \
        $argc                             \
        /usr/bin/node ~/prog.js           \
    > /mnt/out/out$testcount.txt          \
    2> /mnt/out/err$testcount.txt
    # get stderr
    echo $? > /mnt/out/errcode$testcount.txt
done


