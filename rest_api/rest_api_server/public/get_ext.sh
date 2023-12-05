#!/bin/bash
cd `dirname $0`
lang=$1
eval "cat ../app/ext.json | grep '\"$lang\":' | sed -e 's/^[ \t]*\\\"$lang\\\"[ \t]*\\:[ \t]*\\\"\\(.*\\)\\\"[\\,]*$/\\1/' | sed -e 's/\\\\n/\\n/g'" 
