#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /home/tal/bin/elixir tal-$(basename `pwd`):latest --version 2> /dev/null | tail -n 1

