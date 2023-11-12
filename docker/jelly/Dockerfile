FROM ubuntu:latest

RUN apt update -q -y
RUN apt upgrade -q -y
RUN apt-get -y install python3-pip python3-wheel git
RUN addgroup tal
RUN adduser --home /home/tal --shell /bin/bash --uid 1000 --gid 1000 tal
RUN chown tal:tal /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

WORKDIR /home/tal
RUN git clone -q https://github.com/DennisMitchell/jellylanguage.git
WORKDIR /home/tal/jellylanguage
ENV PATH=/home/tal/.local/bin:$PATH
RUN pip3 install --upgrade --user .
