##################################################### -*- sh -*- #####
# build stage
FROM alpine:latest AS builder

RUN apk update
RUN apk add --update --no-cache git build-base gcc linux-headers tar autoconf emacs
RUN apk add automake --repository https://dl-3.alpinelinux.org/alpine/edge/main/
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal

# leave root user
USER tal:tal

RUN printf '(setq-default indent-tabs-mode nil)\n(setq-default c-basic-offset 4)\n' > .emacs
COPY --chown=tal:tal bc-1.07-tal /home/tal/bc-1.07-tal
RUN cd ~/bc-1.07-tal && \
    autoreconf -i && \
    ./configure --prefix=/home/tal/ && \
    cd lib && \
    make && \
    cd ../dc && \
    make && \
    cp dc /home/tal/  && \
    cd /home/tal/

######################################################################
# final stage
FROM alpine:latest

RUN apk update
RUN apk add --update 
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal
# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in && mkdir /mnt/out

COPY --from=builder /home/tal/dc ./

