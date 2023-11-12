##################################################### -*- sh -*- #####
# build stage
FROM alpine:latest AS builder

RUN apk update
RUN apk add build-base make cmake gcc g++ unzip autoconf  bison re2c libxml2 libxml2-dev sqlite-dev sqlite git
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal

# leave root user
USER tal:tal

RUN git clone --single-branch --branch PHP-8.1.10  https://github.com/php/php-src.git
WORKDIR /home/tal/php-src
RUN ./buildconf && ./configure --prefix=/home/tal/php && make && make install

######################################################################
# final stage
FROM alpine:latest

RUN apk update
RUN apk add --update gcc musl-dev libxml2 sqlite sqlite-dev
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal
# compile
COPY --chown=tal:tal launch.sh /home/tal/launch.sh
COPY --chown=root:root php.ini /etc/php7/php.ini

# leave root user
USER tal:tal
RUN mkdir /mnt/in && mkdir /mnt/out

COPY --from=builder /home/tal/php /home/tal/php

# remove some binaries
USER root:root
RUN rm -f /usr/bin/perl /usr/bin/tr /bin/ls /bin/ln
USER tal:tal
