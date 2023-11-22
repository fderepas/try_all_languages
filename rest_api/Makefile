default:
	@echo "type 'make test' to launch tests"

.PHONY:test
test:
	cd rest_api_server && make install
	cd rest_api_server && make  &
	sleep 10
	cd rest_api_server_test && make

clean:
	rm -f *~
	for i in `/bin/ls -F | grep '/'`; do cd $$i; make clean; cd ..; done

