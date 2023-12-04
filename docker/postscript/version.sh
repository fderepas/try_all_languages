#!/bin/bash
# arguments after the entry point are given after image name
echo ghostscript $(docker run --rm --entrypoint /usr/bin/gs tal-$(basename `pwd`):latest --version | head -n 1)
