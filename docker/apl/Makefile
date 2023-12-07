default:
	./build.sh
.PHONY:test
test :
	rm -rf test
	mkdir test && cp ../Makefile.test.sub.dir test/Makefile
	cd test && make 

clean:
	rm -fr *~ test/
	rm -f apl.deb wget-log
