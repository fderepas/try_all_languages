#!/bin/bash
# This script builds docker images which do not already exist.

# change to the location of the script
cd `dirname $0`
# function to push an image to docker hub
push_to_registry () {
    docker tag tal-$1:$3 $2/tal-$1:$3
    docker push $2/tal-$1:$3
}
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
        echo testing $j
        make test > /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
            printf \\033[32mOK\\033[0m"\n"
            push_to_registry $j fderepas latest
        else
            printf \\033[31mtest_\KO\\033[0m"\n"
        fi
    else
        # build and test
        echo Building docker for $j
        make > /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
            make test > /dev/null 2> /dev/null
            if [ $? -eq 0 ]; then
                printf \\033[32mOK\\033[0m"\n"
                push_to_registry $j fderepas latest
            else
                printf \\033[31mtest_\KO\\033[0m"\n"
            fi
        else
            printf \\033[31mKO\\033[0m"\n"
        fi
    fi
    cd ..
done
