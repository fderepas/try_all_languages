#!/bin/bash
# arguments after the entry point are given after image name
basename `docker run --rm --entrypoint /usr/bin/pwd tal-j:latest`

