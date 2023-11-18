default:
	./build.sh
.PHONY:test
test :
	cd test && make test

run :
	docker run --runtime=sysbox-runc -it  --mount type=bind,source=`pwd`/../..,target=/mnt/ tal-allvms:latest

install:
	bash install_sysbox.sh

clean:
	rm -f *~ *.deb
	cd test && make clean

#create registry
#docker run -d -p 5000:5000 --restart always --name registry registry:2
#Edit the /etc/docker/daemon.json to have the following line
#{ "insecure-registries": ["your_hostname.local:5000"] }
# docker tag tal-bash:latest nvi.local:5000/tal-bash:latest
# docker push nvi.local:5000/tal-bash:latest
