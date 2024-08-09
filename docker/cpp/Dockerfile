FROM tal_base_alpine:latest

RUN apk add --update build-base 
RUN apk add --update --repository https://dl-3.alpinelinux.org/alpine/edge/main/ clang libstdc++
WORKDIR /mnt
# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh
# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

