FROM tal_base_alpine:latest

RUN apk add --update build-base gcc --repository https://dl-3.alpinelinux.org/alpine/edge/main/

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

RUN mkdir /mnt/in
RUN mkdir /mnt/out
