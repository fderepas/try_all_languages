#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /usr/bin/ls tal-$(basename `pwd`):latest /opt | head -n 1
