#!/bin/bash
# arguments after the entry point are given after image name
commit=`docker run --rm --entrypoint git tal-jelly:latest  rev-parse HEAD`
echo github.com/DennisMitchell/jellylanguage.git $commit
