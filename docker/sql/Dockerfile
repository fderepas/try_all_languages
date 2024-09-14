FROM tal_base_alpine:latest

COPY init.sql /root/init.sql

RUN apk add openrc mariadb && \
    mkdir /run/openrc/ && \
    touch /run/openrc/softlevel && \
    /etc/init.d/mariadb setup && \
    cd '/usr' && \
    /usr/bin/mariadbd-safe --datadir='/var/lib/mysql' --no-watch && \
    apk add mariadb-client && \
    cat /root/init.sql | mariadb

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

RUN mkdir /mnt/in
RUN mkdir /mnt/out
