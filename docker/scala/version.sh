#!/bin/sh
# arguments after the entry point are given after image name
docker run --rm --entrypoint /home/tal/.cache/scalacli/local-repo/bin/scala-cli/scala-cli tal-$(basename `pwd`):latest --version | grep 'default' | cut -d ':' -f 2
