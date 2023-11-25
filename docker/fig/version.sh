#!/bin/bash
cd `dirname $0`
cat Dockerfile | grep Seggan | sed -e 's/^.*download\/\(.*\)$/\1/'
