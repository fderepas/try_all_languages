FROM alpine:latest

RUN apk update
RUN apk add --update perl nodejs npm bash --repository https://dl-3.alpinelinux.org/alpine/edge/main/
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh
RUN npm install -g typescript

# leave root user
USER tal:tal
WORKDIR /home/tal
RUN npm install readline-sync
RUN mkdir /mnt/in
RUN mkdir /mnt/out

