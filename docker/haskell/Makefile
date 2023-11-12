default:
	./build.sh
.PHONY:test
test :
	cd test && make test

.PHONY:create
create :
	docker save tal-haskell:latest | gzip > tal-haskell.tar.gz

transfert:
	scp tal-haskell.tar.gz 34.230.42.82:~/
	scp tal-haskell.tar.gz 52.90.199.171:~/
	scp tal-haskell.tar.gz 54.172.74.117:~/
	scp tal-haskell.tar.gz 52.54.221.12:~/
	scp tal-haskell.tar.gz 3.89.217.90:~/


clean:
	rm -f *~ 
	cd test && make clean

