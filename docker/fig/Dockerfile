FROM alpine:latest

RUN apk update
RUN apk add --update openjdk17 wget
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

WORKDIR /home/tal
RUN wget https://github.com/Seggan/Fig/releases/download/1.6.1/Fig-1.6.1.jar
RUN ln -s Fig-1.6.1.jar fig.jar
