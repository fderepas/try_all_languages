#!/bin/bash
cd `dirname $0`
lang=$1
# original cmd
#cat progs.json | grep '"apl":' | sed -e 's/^[ \t]*\"apl\"\:\"\(.*\)\"[\,]*$/\1/' | sed -e 's/\\n/\n/g'
#eval "cat progs.json | grep '\"$lang\":' | sed -e 's/^[ \t]*\\\"$lang\\\"[ \t]*\\:[ \t]*\\\"\\(.*\\)\\\"[\\,]*$/\\1/' | sed -e 's/\\\\n/\\n/g' | sed -e 's/\\\\\"/\"/g' "
pyfname=/tmp/_py_f_$$.py
printf "d="> $pyfname
cat progs.json >> $pyfname
echo "print(d['$lang'])">> $pyfname
python3 $pyfname
rm $pyfname
