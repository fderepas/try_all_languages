FROM ubuntu:latest

RUN apt update -q -y && \
    apt upgrade -q -y && \
    apt-get -y install python3-pip python3-wheel git && \
    adduser --disabled-password --gecos "" tal && \
    chown tal:tal /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal

RUN mkdir /mnt/in /mnt/out
WORKDIR /home/tal
ENV PATH=/home/tal/.local/bin:$PATH
RUN pip install vyxal
