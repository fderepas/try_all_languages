FROM alpine:latest

RUN apk update
RUN apk add openjdk21 --repository https://dl-3.alpinelinux.org/alpine/edge/community/
RUN apk add bash curl git zip 

RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh
RUN chmod 777 /mnt

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out
RUN chmod 777 /mnt/out

RUN curl -s "https://get.sdkman.io" | bash 

RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install groovy"
WORKDIR /home/tal/

