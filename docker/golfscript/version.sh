#!/bin/bash
# arguments after the entry point are given after image name
commit=`docker run --rm --entrypoint git tal-golfscript:latest  rev-parse HEAD`
echo https://github.com/darrenks/golfscript $commit
