#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /usr/bin/node tal-$(basename `pwd`):latest --version | head -n 1 | sed -e 's/^v//'
