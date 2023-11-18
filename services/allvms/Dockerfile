FROM nestybox/ubuntu-jammy-systemd-docker:latest
RUN apt update && \
  apt install make vim wget -y && \
  mkdir -p /etc/docker/ && \
  mkdir -p /home/admin/ && \
  echo '{ "insecure-registries": ["'`/sbin/ip route|awk '/default/ { print $3 }'`':5000"] }' > /etc/docker/daemon.json 

COPY --chown=admin:admin ../vmfrontend /home/admin/

COPY --chown=admin:admin image_pull.sh /home/admin/

## Set systemd as entrypoint.
#ENTRYPOINT [ "/sbin/init", "--log-level=err" ]

# run script.sh
COPY rest_api_server.sh /usr/bin/
COPY custom.service /lib/systemd/system/
RUN chmod +x /usr/bin/rest_api_server.sh &&                      \
    ln -sf /lib/systemd/system/custom.service                    \
       /etc/systemd/system/multi-user.target.wants/custom.service
       
