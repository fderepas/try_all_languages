FROM alpine:latest

RUN apk update
RUN apk add bash icu-libs krb5-libs libgcc libintl libssl3 libstdc++ zlib wget
RUN apk add libgdiplus --repository https://dl-3.alpinelinux.org/alpine/edge/testing/
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
RUN wget https://dot.net/v1/dotnet-install.sh
RUN bash ./dotnet-install.sh -c Current
RUN mkdir foo
WORKDIR /home/tal/foo
RUN /home/tal/.dotnet/dotnet new console
