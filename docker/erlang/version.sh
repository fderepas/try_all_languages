#!/bin/bash
# arguments after the entry point are given after image name
docker run --rm --entrypoint /home/tal/erlang/bin/erl tal-$(basename `pwd`):latest -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), io:fwrite(Version), halt().' -noshell 2> /dev/null

#/usr/bin/elixir tal-$(basename `pwd`):latest --version 2> /dev/null | tail -n 1
