FROM ubuntu:latest

RUN apt-get clean && \
  apt-get update -q -y && \
  apt upgrade -q -y && \
  apt install -y apt-utils gnucobol adduser && \
  adduser --disabled-password --gecos "" tal && \
  chown tal:tal /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal

RUN mkdir /mnt/in
RUN mkdir /mnt/out

WORKDIR /home/tal/

