FROM alpine:latest

RUN apk update
RUN apk add --update --no-cache bash --repository https://dl-3.alpinelinux.org/alpine/edge/main/
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# remove useless stuff
RUN rm /usr/bin/awk

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out
