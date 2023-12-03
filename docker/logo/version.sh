#!/bin/bash
cd `dirname $0`
grep github.com/jrincayc Dockerfile | sed -e 's/^.*\(\ucb[^ ]*\).*$/\1/'  | sed -e 's/\.tar\.gz//'

