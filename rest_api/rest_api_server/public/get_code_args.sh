#!/bin/bash
cd `dirname $0`
lang=$1
pyfname=/tmp/_py_f_$$.py
printf "d="> $pyfname
cat progs_args.json >> $pyfname
echo "print(d['$lang'])">> $pyfname
python3 $pyfname
rm $pyfname
