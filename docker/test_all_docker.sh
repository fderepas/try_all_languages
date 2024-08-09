#!/bin/bash
# This script builds docker images which do not already exist.

# change to the location of the script
cd `dirname $0`

# loop on all languages
for i in `ls -F | grep / `; do
    cd $i
    j=`echo $i | tr -d '/'`
    # image was done today
    #c=$(docker images | grep ^tal-$j | grep `date +"%Y%m%d"` | wc -l)
    # image exits
    c=$(docker images | grep ^tal-$j' ' | grep latest | wc -l)
    if [ $c -eq 1 ]; then
        # an image is already here, just test
        make test > /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
            printf \\033[32m"$j OK"\\033[0m"\n"
        else
            printf \\033[31m"$j: test KO"\\033[0m"\n"
	fi
    else
        printf \\033[31m"no image for $j"\\033[0m"\n"
    fi
    cd ..
done
