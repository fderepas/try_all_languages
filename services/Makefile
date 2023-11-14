default:
	@echo "type 'make test' to launch tests"

.PHONY:test
test:
	cd vmfrontend && make install
	cd vmfrontend && make  &
	sleep 10
	cd vmfrontend_test && make

clean:
	rm -f *~
	for i in `/bin/ls -F | grep '/'`; do cd $$i; make clean; cd ..; done

