FROM alpine:latest

RUN apk update
RUN apk add --update wget tar gzip
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

RUN wget https://julialang-s3.julialang.org/bin/musl/x64/1.9/julia-1.9.3-musl-x86_64.tar.gz && \
    tar xvfz julia-*-musl-x86_64.tar.gz && \
    rm julia-*-musl-x86_64.tar.gz && \
    ln -s julia-* julia
