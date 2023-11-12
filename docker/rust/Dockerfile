FROM alpine:latest

RUN apk update

RUN apk add --update --no-cache llvm15-libs --repository https://dl-3.alpinelinux.org/alpine/edge/main/
RUN apk add --update --no-cache rust --repository https://dl-3.alpinelinux.org/alpine/edge/community/
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in /mnt/out
