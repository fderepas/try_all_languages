default:
	@echo "type 'make test' to launch tests"

.PHONY:test
test:
	cd services && make test

clean:
	rm -f *~
	for i in `/bin/ls -F | grep '/'`; do cd $$i; make clean; cd ..; done

