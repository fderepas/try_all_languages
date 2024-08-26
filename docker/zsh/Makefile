default:
	./build.sh

.PHONY:test
test :
	rm -rf test
	mkdir test && cp ../Makefile.test.sub.dir test/Makefile
	cd test && make 
	rm -rf test_args
	mkdir test_args && cp ../Makefile.test_args.sub.dir test_args/Makefile
	cd test_args && make 

clean:
	rm -rf *~ test/ test_args/


