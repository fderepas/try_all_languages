default:
	./build.sh
.PHONY:test
test :
	cd test && make test

clean:
	rm -f *~ 
	cd test && make clean
	rm -rf node_modules/ package.json package-lock.json downloaded.html

