#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /home/tal/venv/bin/pip3 tal-vyxal:latest show vyxal | grep ^Version: | sed -e 's/Version://' | tr -d ' '
