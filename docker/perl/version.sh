#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /usr/bin/perl tal-$(basename `pwd`):latest --version | head -n 2 | tail -n 1
