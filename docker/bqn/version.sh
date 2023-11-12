#!/bin/bash
# arguments after the entry point are given after image name
name=$(basename `pwd`)
echo CBQN git `docker run --rm --entrypoint /bin/cat tal-$name:latest /home/tal/CBQN_git_hash.txt `
