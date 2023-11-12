##################################################### -*- sh -*- #####
# build stage
FROM alpine:latest AS builder

RUN apk update
RUN apk add --update build-base make cmake unzip
RUN apk add --update wget tar gzip xz gcc sed gmp-dev
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal

# leave root user
USER tal:tal
WORKDIR /home/tal

RUN wget https://downloads.haskell.org/~ghc/9.8.1/ghc-9.8.1-x86_64-alpine3_12-linux-static-int_native.tar.xz && \
    tar -xf ghc-9.8.1-x86_64-alpine3_12-linux-static-int_native.tar.xz && \
    rm -rf ghc-9.8.1-x86_64-alpine3_12-linux-static-int_native.tar.xz && \
    cd /home/tal/ghc-9.8.1-x86_64-unknown-linux && \
    ./configure --prefix=/home/tal/ghc && \
    make install && \
    cd .. && \
    rm -rf /home/tal/ghc-9.8.1-x86_64-unknown-linux

######################################################################
# final stage
FROM alpine:latest

RUN apk update
RUN apk add --update gmp-dev gcc musl-dev
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

# script to launch the program
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# delete useless files
USER root:root
RUN rm /usr/bin/tr
RUN rm /bin/ls

# leave root user
USER tal:tal

# create mount point to read/write data
RUN mkdir /mnt/in /mnt/out

# set default workdir
WORKDIR /home/tal

# copy ghc
COPY --from=builder /home/tal/ghc /home/tal/ghc
