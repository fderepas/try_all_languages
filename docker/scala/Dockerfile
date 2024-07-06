##################################################### -*- sh -*- #####
FROM ubuntu:latest

RUN apt update -q -y && \
    apt upgrade -q -y && \
    apt install -y curl adduser && \
    adduser --disabled-password --gecos "" tal && \
    chown tal:tal /mnt

# compile
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

WORKDIR /home/tal

# https://scala-cli.virtuslab.org/install/
RUN curl -sSLf https://virtuslab.github.io/scala-cli-packages/scala-setup.sh | sh && printf "@main def HelloWorld(args: String*): Unit =\n  println(\"Hello, World!\")" > foo.scala && /home/tal/.cache/scalacli/local-repo/bin/scala-cli/scala-cli foo.scala 

