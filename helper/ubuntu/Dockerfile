##################################################### -*- sh -*- #####
# build stage to compile execve_wrapper.c
FROM ubuntu:latest AS builder

RUN apt-get clean && \
  apt-get update -q -y && \
  apt upgrade -q -y && \
  apt install -y make gcc adduser && \
  adduser --disabled-password --gecos "" tal && \
  chown tal:tal /mnt

# leave root user
USER tal:tal
WORKDIR /home/tal
COPY --chown=tal:tal execve_wrapper.c /home/tal/execve_wrapper.c
RUN gcc -o execve_wrapper execve_wrapper.c

######################################################################
# final stage
FROM ubuntu:latest

RUN apt-get clean && \
  apt-get update -q -y && \
  apt upgrade -q -y && \
  apt install -y adduser && \
  adduser --disabled-password --gecos "" tal && \
  chown tal:tal /mnt

USER tal:tal
WORKDIR /home/tal
COPY --from=builder /home/tal/execve_wrapper /home/tal/execve_wrapper
USER root:root
