FROM alpine:latest

RUN apk update
RUN apk add --update perl nodejs npm bash --repository https://dl-3.alpinelinux.org/alpine/edge/main/
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt
RUN npm install -g sass

WORKDIR /mnt

# Copy
## Launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh
## Built-ins functions
COPY --chown=tal:tal functions.scss /home/tal/functions.scss

# Leave root user
USER tal:tal
WORKDIR /home/tal
RUN npm install readline-sync
RUN mkdir /mnt/in
RUN mkdir /mnt/out

USER root:root
USER tal:tal
