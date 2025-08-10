FROM tal_base_alpine:latest

COPY init.sql /root/init.sql

RUN apk add openrc mariadb mariadb-client && \
    mkdir /run/openrc/ && \
    touch /run/openrc/softlevel && \
    /etc/init.d/mariadb setup && \
    /usr/bin/mariadbd-safe --datadir='/var/lib/mysql' --no-watch && \
    sleep 10 && \
    cat /root/init.sql | mariadb && \
    sleep 10 && \
    mkdir /mnt/in && \
    mkdir /mnt/out

WORKDIR /mnt

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

