##################################################### -*- sh -*- #####
# build stage
FROM ubuntu:latest AS builder

RUN apt update -q -y && \
    apt upgrade -q -y  && \
    apt install wget gnupg apt-utils git gcc libncurses5-dev libncursesw5-dev make locales -y && \
    adduser --disabled-password --gecos "" tal && \
    chown tal:tal /mnt && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8


# leave root user
USER tal:tal

WORKDIR /home/tal
RUN echo "### compiling erlang" && \
    git clone https://github.com/erlang/otp.git && \
    cd otp && \
    git checkout maint-25 && \
    ./configure --prefix=/home/tal/erlang && \
    make && \
    make install && \
    cd /home/tal && \
    echo done

######################################################################
# final stage
FROM ubuntu:latest

RUN apt update -q -y && \
    apt upgrade -q -y  && \
    apt install gnupg apt-utils libncurses5-dev libncursesw5-dev locales adduser -y && \
    adduser --disabled-password --gecos "" tal && \
    chown tal:tal /mnt && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# copy from builder stage
COPY --from=builder /home/tal/erlang /home/tal/erlang
RUN chown tal:tal /home/tal/erlang

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in /mnt/out
