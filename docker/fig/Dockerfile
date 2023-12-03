FROM alpine:latest

RUN apk update && \
    apk add openjdk21 --repository https://dl-3.alpinelinux.org/alpine/edge/community/ && \
    apk add --update wget && \
    addgroup tal && \
    adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal && \
    chown tal:tal /mnt

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

WORKDIR /home/tal
RUN wget https://github.com/Seggan/Fig/releases/download/1.9.0/Fig-1.9.0.jar
RUN ln -s Fig-1.9.0.jar fig.jar
