##################################################### -*- sh -*- #####
FROM ubuntu:latest

RUN apt update -q -y 
RUN apt upgrade -q -y
RUN apt install -y curl 
RUN adduser --disabled-password --gecos "" tal
RUN chown tal:tal /mnt

# compile
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

WORKDIR /home/tal

# https://scala-cli.virtuslab.org/install/
RUN curl -sSLf https://virtuslab.github.io/scala-cli-packages/scala-setup.sh | sh && printf "@main def HelloWorld(args: String*): Unit =\n  println(\"Hello, World!\")" > foo.scala && /home/tal/.cache/scalacli/local-repo/bin/scala-cli/scala-cli foo.scala 

############################# alpine version too slow
#FROM alpine:latest
#
#RUN apk update
#RUN apk add --update openjdk17 ncurses wget bash tar curl gzip git
#RUN addgroup tal
#RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
#RUN chown tal:tal /mnt
#
## compile
#COPY --chown=tal:tal launch.sh /home/tal/launch.sh
## leave root user
#USER tal:tal
#
#WORKDIR /home/tal/

# https://scala-cli.virtuslab.org/install/
#RUN curl -sSLf https://virtuslab.github.io/scala-cli-packages/scala-setup.sh | sh && printf "@main def HelloWorld(args: String*): Unit =\n  println(\"Hello, World!\")" > foo.scala && /home/tal/.cache/scalacli/local-repo/bin/scala-cli/scala-cli foo.scala 
