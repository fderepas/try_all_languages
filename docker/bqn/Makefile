default:
	./build.sh

.PHONY:test
test :
	cd test && make test

clean:
	rm -f *~ nohup*.out
	cd test && make clean

nohup:
	nohup make > nohup.out 2> nohup2.out &

