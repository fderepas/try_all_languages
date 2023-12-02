#!/bin/bash
cat build.sh | grep "download.dyalog.com" | sed -e 's/^.*file=//' | sed -e 's/\/linux.*//'
docker run --rm --entrypoint /usr/bin/swiftc tal-$(basename `pwd`):latest --version | head -n 1


