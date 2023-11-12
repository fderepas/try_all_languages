##################################################### -*- sh -*- #####
# build stage
FROM alpine:latest AS builder

RUN apk update
RUN apk add build-base make cmake gcc g++ unzip autoconf bison re2c git bash libffi-dev 
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal

# leave root user
USER tal:tal

RUN git clone https://github.com/dzaima/CBQN && \
    mkdir bin && \
    cd CBQN && \
    git rev-parse --short HEAD > ../CBQN_git_hash.txt && \
    make CC=gcc && \
    make install CC=gcc PREFIX=/home/tal

######################################################################
# final stage
FROM alpine:latest

RUN apk update
RUN apk add libffi-dev
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal
# compile
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in && mkdir /mnt/out

RUN mkdir /home/tal/bin
COPY --from=builder /home/tal/bin/bqn /home/tal/bin/bqn
COPY --from=builder /home/tal/CBQN_git_hash.txt /home/tal/CBQN_git_hash.txt 

# remove some binaries
USER root:root
RUN rm -f /usr/bin/perl /usr/bin/tr /bin/ls /bin/ln
USER tal:tal
