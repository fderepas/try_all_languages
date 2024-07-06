FROM ubuntu:latest

RUN apt update -q -y && \
    apt upgrade -q -y && \
    apt install -y apt-utils make cmake unzip git wget tar gzip xzdec gcc sed libgmp3-dev python3 adduser && \
    addgroup tal && \
    adduser --home /home/tal --shell /bin/bash --uid 1001 --gid 1001 tal && \
    chown tal:tal /mnt

WORKDIR /home/tal

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

RUN git clone https://codeberg.org/ngn/k.git
WORKDIR /home/tal/k
RUN make CC=/usr/bin/gcc
