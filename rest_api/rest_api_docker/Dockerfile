FROM nestybox/ubuntu-jammy-systemd-docker:latest
RUN apt update && \
  apt install make vim wget nodejs npm -y && \
  mkdir -p /home/admin/
  
COPY --chown=admin:admin rest_api_server /home/admin/rest_api_server/
COPY --chown=admin:admin image_pull.sh /home/admin/


## run script.sh
COPY rest_api_server.sh /usr/bin/
COPY custom.service /lib/systemd/system/
RUN chmod +x /usr/bin/rest_api_server.sh &&                      \
    ln -sf /lib/systemd/system/custom.service                    \
       /etc/systemd/system/multi-user.target.wants/custom.service
       
#ENTRYPOINT [ "/bin/bash" ]
## Set systemd as entrypoint.
ENTRYPOINT [ "/sbin/init", "--log-level=err" ]
