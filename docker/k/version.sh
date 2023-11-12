#!/bin/bash
# arguments after the entry point are given after image name
commit=`docker run --rm --entrypoint git tal-k:latest  rev-parse HEAD`
echo github.com/kevinlawler/kona.git $commit
