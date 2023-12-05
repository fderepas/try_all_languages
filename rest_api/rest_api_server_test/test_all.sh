#!/bin/bash
cd `dirname $0`

for i in ` cat ../rest_api_server/app/ext.json | grep '"' | cut -d '"' -f 2`;  do
    rm -rf $i
    mkdir $i
    cd $i
    printf $i' '
cat <<EOF > Makefile
default:
	make -f ../Makefile.to.call.from.subdir 
clean:
	make -f ../Makefile.to.call.from.subdir clean
EOF
    make > /dev/null 2> /dev/null
    if [ $? -ne 0 ]; then
        printf "\033[31merror\033[0m";
    else
        printf "\033[32mok\033[0m";
    fi
    echo
    cd ..
done



