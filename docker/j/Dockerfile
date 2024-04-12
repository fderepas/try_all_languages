 FROM ubuntu:latest

RUN apt update -q -y && \
    apt upgrade -q -y && \
    apt install -y apt-utils &&  \
    apt install -y make cmake unzip git  wget tar gzip && \
    adduser --disabled-password --gecos "" tal && \
    chown tal:tal /mnt

WORKDIR /home/tal

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in /mnt/out

WORKDIR /home/tal/
RUN wget https://www.jsoftware.com/download/j9.5/install/j9.5_linux64.tar.gz && tar xvfz j9.5_linux64.tar.gz
WORKDIR /home/tal/j9.5
