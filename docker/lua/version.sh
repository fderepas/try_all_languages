#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /usr/bin/lua5.4 tal-$(basename `pwd`):latest -v | head -n 1
