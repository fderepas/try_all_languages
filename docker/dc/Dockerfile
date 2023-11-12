##################################################### -*- sh -*- #####
# build stage
FROM alpine:latest AS builder

RUN apk update
RUN apk add --update --no-cache git build-base gcc linux-headers tar emacs 
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal

# leave root user
USER tal:tal

RUN printf '(setq-default indent-tabs-mode nil)\n(setq-default c-basic-offset 4)\n' > .emacs
COPY --chown=tal:tal bc-1.07-tal.tar.gz /home/tal/bc-1.07-tal.tar.gz
RUN tar xvfz bc-1.07-tal.tar.gz && \
    cd ~/bc-1.07-tal && \
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

