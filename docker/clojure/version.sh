#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /usr/bin/java tal-$(basename `pwd`):latest -jar /home/tal/clojure/clojure.jar  2> /dev/null | head -n 1
