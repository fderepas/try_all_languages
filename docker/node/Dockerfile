FROM tal_base_alpine_dev:latest

RUN apk add --update perl nodejs npm bash --repository https://dl-3.alpinelinux.org/alpine/edge/main/

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
WORKDIR /home/tal
RUN npm install readline-sync
RUN mkdir /mnt/in
RUN mkdir /mnt/out

USER root:root
#RUN rm -f /usr/bin/tr /bin/ls
USER tal:tal
