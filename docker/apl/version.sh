#!/bin/bash
cat Dockerfile | grep "download.dyalog.com" | sed -e 's/^.*file=//' | sed -e 's/\/linux.*//'

