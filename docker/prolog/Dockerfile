FROM alpine:latest

RUN apk update
RUN apk add bash g++ make cmake wget gmp gmp-dev ncurses ncurses-dev readline zlib zlib-dev sed
RUN addgroup tal
RUN adduser -h /home/tal -g '' -s /bin/ash -G tal -D tal
RUN chown tal:tal /mnt

WORKDIR /home/tal

RUN chown tal /mnt

# leave root user
USER tal:tal
RUN mkdir /mnt/in
RUN mkdir /mnt/out

# compile from source
RUN wget https://www.swi-prolog.org/download/stable/src/swipl-8.4.3.tar.gz && \
  tar xvfz swipl*.tar.gz && \
  rm swipl*.tar.gz && \
  cd swipl* && \
  mkdir build && \
  cd build && \
  cmake -DCMAKE_INSTALL_PREFIX=/home/tal/prolog .. && \
  mkdir -p man && \
  touch man/ssl && \
  touch man/archive && \
  mkdir -p packages/http && \
  touch packages/http/ssl && \
  make && \
  make install && \
  cd /home/tal && \
  rm -rf swipl*

# copy launch script
COPY --chown=tal:tal launch.sh /home/tal/launch.sh
