#!/bin/bash
# arguments after the entry point are given after image name
#echo "https://www.eclipseclp.org/" `docker run --rm --entrypoint /bin/head tal-prolog:latest -n 1 lib/version.pl`
docker run --rm --entrypoint /home/tal/prolog/bin/swipl tal-prolog:latest --version



