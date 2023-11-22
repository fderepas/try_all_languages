#!/bin/bash
set -e
mkdir -p ../tmp
rm -f err_codes.txt
touch err_codes.txt
initpwd=`pwd`
array=($(ls -F | grep /$))
nb=${#array[@]}
echo there are $nb virtutal machines
kmax=10
for k in {1..$kmax}
do
    i=$(( RANDOM % nb ))
    dirname=tmp_$RANDOM
    rm -rf ../tmp/$dirname
    d=${array[$i]}
    cp -r $d ../tmp/$dirname
    cd ../tmp/$dirname
    echo -e "#!/bin/bash\nset -e\nset -x\nmake\necho \$? $d >> $initpwd/err_codes.txt\ncd ..\nrm -r $dirname" > script.sh
    bash script.sh > /dev/null 2> /dev/null &
    cd $initpwd
done
d=0
while [[ "$d" != "$kmax" ]]
do
    uptime
    d=`wc -l err_codes.txt`
    echo $d
    ps aux | grep docker
    sleep 3
done
