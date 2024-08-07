FROM ubuntu:latest

RUN apt-get clean && \
  apt-get update -q -y && \
  apt upgrade -q -y && \
  apt install -y libncurses6 libncurses-dev make gcc g++ unzip bison wget texinfo adduser && \
  apt install -y libqt5core5t64 libqt5gui5t64 libqt5network5t64 libqt5gui5t64 libqt5printsupport5t64 libqt5svg5 libqt5widgets5t64 libqt5xml5t64 libqt5xmlpatterns5 && \
  adduser --disabled-password --gecos "" tal && \
  chown tal:tal /mnt

RUN wget https://www.atelierb.eu/wp-content/uploads/2024/04/atelierb-free-24.04-ubuntu-24.04.deb && \
  dpkg -i /atelierb-free-24.04-ubuntu-24.04.deb && \
  rm -rf atelierb-free-24.04-ubuntu-24.04.deb 
  

