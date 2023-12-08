default:
	./build.sh
.PHONY:test
test :
	cd test && make test

run :
	bash run.sh

install:
	bash install_sysbox.sh

clean:
	rm -f *~ *.deb
	rm -rf rest_api_server
	cd docker-registry && make clean

#create registry
#docker run -d -p 5000:5000 --restart always --name registry registry:2
#Edit the /etc/docker/daemon.json to have the following line
#{ "insecure-registries": ["your_hostname.local:5000"] }
# docker tag tal-bash:latest nvi.local:5000/tal-bash:latest
# docker push nvi.local:5000/tal-bash:latest
# on host
# iptables -A INPUT -i docker0 -j ACCEPT
