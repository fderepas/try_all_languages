#!/bin/bash
docker load < /mnt/images/tal-allvms.tar.gz
docker load < /mnt/images/tal-apl.tar.gz
docker load < /mnt/images/tal-bash.tar.gz
docker load < /mnt/images/tal-bqn.tar.gz
docker load < /mnt/images/tal-clojure.tar.gz
docker load < /mnt/images/tal-cpp.tar.gz
docker load < /mnt/images/tal-csharp.tar.gz
docker load < /mnt/images/tal-c.tar.gz
docker load < /mnt/images/tal-docker.tar.gz
docker load < /mnt/images/tal-elixir.tar.gz
docker load < /mnt/images/tal-fsharp.tar.gz
docker load < /mnt/images/tal-golfscript.tar.gz
docker load < /mnt/images/tal-go.tar.gz
docker load < /mnt/images/tal-haskell.tar.gz
docker load < /mnt/images/tal-java.tar.gz
docker load < /mnt/images/tal-jelly.tar.gz
docker load < /mnt/images/tal-j.tar.gz
docker load < /mnt/images/tal-julia.tar.gz
docker load < /mnt/images/tal-kotlin.tar.gz
docker load < /mnt/images/tal-k.tar.gz
docker load < /mnt/images/tal-lua.tar.gz
docker load < /mnt/images/tal-node.tar.gz
docker load < /mnt/images/tal-ocaml.tar.gz
docker load < /mnt/images/tal-perl.tar.gz
docker load < /mnt/images/tal-php.tar.gz
docker load < /mnt/images/tal-powershell.tar.gz
docker load < /mnt/images/tal-prolog.tar.gz
docker load < /mnt/images/tal-python.tar.gz
docker load < /mnt/images/tal-raku.tar.gz
docker load < /mnt/images/tal-rest_api_docker.tar.gz
docker load < /mnt/images/tal-r.tar.gz
docker load < /mnt/images/tal-ruby.tar.gz
docker load < /mnt/images/tal-rust.tar.gz
docker load < /mnt/images/tal-scala.tar.gz
docker load < /mnt/images/tal-vyxal.tar.gz
docker load < /mnt/images/tal-zsh.tar.gz
cd /home/admin/rest_api_server
make install
make
