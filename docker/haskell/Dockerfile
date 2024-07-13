FROM alpine:latest

RUN apk update
RUN apk add --update ghc g++ zlib zlib-dev
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

# script to launch the program
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal

# create mount point to read/write data
RUN mkdir /mnt/in /mnt/out

# set default workdir
WORKDIR /home/tal
