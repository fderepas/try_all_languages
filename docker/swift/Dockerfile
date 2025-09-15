FROM ubuntu:latest

RUN apt-get clean && \
  apt-get update -q -y && \
  apt upgrade -q -y && \
  DEBIAN_FRONTEND=nointeractive apt install -y apt-utils \
          binutils \
          curl \
          git \
          gnupg2 \
          libc6-dev \
          libcurl4-openssl-dev \
          libedit2 \
          libgcc-9-dev \
          libncurses6 \
          libsqlite3-0 \
          libstdc++-9-dev \
          libxml2-dev \
          libz3-dev \
          pkg-config \
          tzdata \
          unzip \
          adduser \
          zlib1g-dev && \
  adduser --disabled-password --gecos "" tal && \
  chown tal:tal /mnt
#RUN curl -s https://archive.swiftlang.xyz/install.sh | bash
#RUN DEBIAN_FRONTEND=nointeractive apt install swiftlang -y

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN cd && \
    curl -O https://download.swift.org/swiftly/linux/swiftly-$(uname -m).tar.gz && \
    tar zxf swiftly-$(uname -m).tar.gz && \
    ./swiftly init --quiet-shell-followup --assume-yes && \
    . "${SWIFTLY_HOME_DIR:-$HOME/.local/share/swiftly}/env.sh" && \
    hash -r


RUN mkdir /mnt/in
RUN mkdir /mnt/out

WORKDIR /home/tal/

