#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /usr/bin/gnat tal-$(basename `pwd`):latest --version | head -n 1
