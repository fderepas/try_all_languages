##################################################### -*- sh -*- #####
# build stage
FROM ubuntu:latest AS builder

RUN apt update -q -y && \
    apt upgrade -q -y  && \
    apt install build-essential wget gnupg apt-utils git gcc g++ libncurses5-dev libncursesw5-dev make locales libssl-dev -y && \
    adduser --disabled-password --gecos "" tal && \
    chown tal:tal /mnt && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    mkdir -p /etc/default && \
    echo 'LANG=en_US.UTF-8' > /etc/default/locale


# leave root user
USER tal:tal

ENV PATH=/home/tal/erlang/bin:/home/tal/bin:$PATH
ENV LANG=en_US.UTF-8 

WORKDIR /home/tal
RUN echo "### compiling erlang" && \
    git clone https://github.com/erlang/otp.git && \
    cd otp && \
    git checkout maint-28 && \
    ./configure --prefix=/home/tal/erlang && \
    make && \
    make install && \
    cd /home/tal
RUN echo "### compiling elixir" && \
    git clone https://github.com/elixir-lang/elixir.git && \
    cd elixir && \
    PREFIX=/home/tal make clean install && \
    echo 'IO.write(IO.read(:stdio, :line))' > prog.exs && \
    echo "123" | elixir prog.exs

######################################################################
# final stage
FROM ubuntu:latest

RUN apt update -q -y && \
    apt upgrade -q -y  && \
    apt install gnupg apt-utils libncurses5-dev libncursesw5-dev locales -y && \
    adduser --disabled-password --gecos "" tal && \
    chown tal:tal /mnt && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# copy from builder stage
COPY --from=builder /home/tal/bin    /home/tal/bin
COPY --from=builder /home/tal/lib    /home/tal/lib
COPY --from=builder /home/tal/share  /home/tal/share
COPY --from=builder /home/tal/erlang /home/tal/erlang

# launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in /mnt/out
                                                                                                                                    
WORKDIR /home/tal
ENV PATH=/home/tal/erlang/bin:/home/tal/bin:$PATH
ENV LANG=en_US.UTF-8 

