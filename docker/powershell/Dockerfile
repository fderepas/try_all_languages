##################################################### -*- sh -*- #####
# build stage
FROM alpine:latest AS builder

RUN apk update
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal

RUN apk add --no-cache \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs \
    curl \
    musl                              && \
    apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
    lttng-ust && \
    curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.2.4/powershell-7.2.4-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz && \
    mkdir -p /opt/microsoft/powershell/7 && \
    tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 && \
    chmod +x /opt/microsoft/powershell/7/pwsh

######################################################################
# final stage

FROM alpine:latest

RUN apk update
RUN apk add --no-cache libgcc libstdc++ icu-libs
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

# create the symbolic link that points to pwsh
RUN ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

WORKDIR /mnt

# compile
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in /mnt/out

COPY --from=builder /opt /opt
