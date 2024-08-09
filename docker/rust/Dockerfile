FROM tal_base_alpine:latest

RUN apk add --update --no-cache rust --repository https://dl-3.alpinelinux.org/alpine/edge/community/
WORKDIR /mnt
COPY --chown=tal:tal launch.sh /home/tal/launch.sh
# leave root user
USER tal:tal
RUN mkdir /mnt/in /mnt/out
