#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /home/tal/php/bin/php tal-$(basename `pwd`):latest --version | head -n 1
