#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /usr/bin/pip tal-vyxal:latest show vyxal | grep ^Version: | sed -e 's/Version://' | tr -d ' '
