##################################################### -*- sh -*- #####
# build stage to compile execve_wrapper.c
FROM alpine:latest AS builder

RUN apk update
RUN apk add --update build-base gcc 
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal

# leave root user
USER tal:tal
WORKDIR /home/tal
COPY --chown=tal:tal execve_wrapper.c /home/tal/execve_wrapper.c
RUN gcc -o execve_wrapper execve_wrapper.c

######################################################################
# final stage
FROM alpine:latest

RUN apk update

RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt
RUN apk add --update build-base gcc vim nmap make
USER tal:tal
WORKDIR /home/tal
COPY --from=builder /home/tal/execve_wrapper /home/tal/execve_wrapper
USER root:root
