default:
	./build.sh

.PHONY:test
test :
	cd test && make test

clean:
	rm -f *~ 
	cd test && make clean
	rm -f apl.deb wget-log
