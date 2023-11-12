#!/bin/sh
printf "scalaVersion\nexit\n" | /home/tal/sbt/bin/sbt 2> /dev/null | grep info | tail -n 2 | head -n 1

