#!/bin/bash
cat build.sh | grep "download.dyalog.com" | sed -e 's/^.*file=//' | sed -e 's/\/linux.*//'

