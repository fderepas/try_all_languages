FROM ubuntu:latest


RUN apt-get clean && \
  apt-get update -q -y && \
  apt upgrade -q -y && \
  apt install -y apt-utils wget libncurses6 adduser && \
  adduser --disabled-password --gecos "" tal && \
  chown tal:tal /mnt

# copy .deb archive 
COPY --chown=tal:tal apl.deb  /tmp/apl.deb

RUN  dpkg -i /tmp/apl.deb && \
     rm /tmp/apl.deb

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal

RUN mkdir /mnt/in
RUN mkdir /mnt/out

WORKDIR /home/tal/

