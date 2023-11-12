#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /home/tal/.sdkman/candidates/kotlin/current/bin/kotlinc tal-$(basename `pwd`):latest -version 2> /tmp/kotlin_$$ 
cat /tmp/kotlin_$$
rm /tmp/kotlin_$$

