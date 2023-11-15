#!/bin/bash
for i in `ls -F | grep / `; do
    cd $i
    j=`echo $i | tr -d '/'`
    # image was done today
    #c=$(docker images | grep tal-$j | grep `date +"%Y%m%d"` | wc -l)
    c=$(docker images | grep ^tal-$j | grep latest | wc -l)
    if [ $c -eq 1 ]; then
        # an image is already here, just test
        echo testing $j
        cd test
        make > /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
            printf \\033[32mOK\\033[0m"\n"
        else
            printf \\033[31mtest_\KO\\033[0m"\n"
        fi
        cd ../..         
    else
        # build and test
        echo Building docker for $j
        make > /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
            cd test
            make > /dev/null 2> /dev/null
            if [ $? -eq 0 ]; then
                printf \\033[32mOK\\033[0m"\n"
            else
                printf \\033[31mtest_\KO\\033[0m"\n"
            fi
            cd ../.. 
        else
            printf \\033[31mKO\\033[0m"\n"
            cd ..
        fi
    fi
done
