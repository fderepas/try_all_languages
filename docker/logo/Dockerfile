FROM tal_base_ubuntu:latest

RUN apt install -y libncurses6 libncurses-dev make gcc g++ unzip bison wget texinfo adduser && \
    cd /root && \
    wget https://github.com/jrincayc/ucblogo-code/releases/download/version_6.2.4/ucblogo-6.2.4.tar.gz && \
    tar xvfz ucblogo-6.2.4.tar.gz && \
    cd ucblogo-6.2.4 && \
    ./configure && \
    sed -i -e 's/LIBS \= \-lm/LIBS \= \-lm \-lncurses/' Makefile && \
    make && \
    make install
WORKDIR /home/tal

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in && mkdir /mnt/out


