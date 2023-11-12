FROM alpine:latest

RUN apk update
RUN apk add --update git
RUN apk add --update --no-cache ruby --repository https://dl-3.alpinelinux.org/alpine/edge/main/ 
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN git clone https://github.com/darrenks/golfscript.git

RUN mkdir /mnt/in
RUN mkdir /mnt/out
WORKDIR /home/tal/golfscript

USER root:root
RUN rm -f /usr/bin/tr /bin/ls
USER tal:tal

