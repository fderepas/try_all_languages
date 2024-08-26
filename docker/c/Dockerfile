FROM tal_base_alpine:latest

RUN apk add --update gcc --repository https://dl-3.alpinelinux.org/alpine/edge/main/ && \
    apk add linux-headers libc-dev

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

RUN mkdir /mnt/in
RUN mkdir /mnt/out
