FROM alpine:latest

RUN apk update
RUN apk add --update openjdk17
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

RUN ln -s /home/tal/launch.sh /home/tal/compile_alpine.sh
