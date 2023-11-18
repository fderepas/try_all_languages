FROM nestybox/ubuntu-jammy-systemd-docker:latest
RUN apt update && \
  apt install make vim wget -y && \
  mkdir /etc/docker/ && \
  echo '{ "insecure-registries": ["'`/sbin/ip route|awk '/default/ { print $3 }'`':5000"] }' > /etc/docker/daemon.json

# Set systemd as entrypoint.
ENTRYPOINT [ "/sbin/init", "--log-level=err" ]


