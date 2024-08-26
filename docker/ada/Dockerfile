FROM alpine:latest

RUN apk update
RUN apk add --update gcc-gnat
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

USER root:root
RUN rm /usr/bin/tr /bin/ls /bin/ln
USER tal:tal
