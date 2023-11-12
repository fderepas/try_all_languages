#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /home/tal/.dotnet/dotnet tal-$(basename `pwd`):latest --info | grep Version | head -n 1
