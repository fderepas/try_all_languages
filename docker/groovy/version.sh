#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /home/tal/.sdkman/candidates/groovy/current/bin/groovy tal-$(basename `pwd`):latest --version


