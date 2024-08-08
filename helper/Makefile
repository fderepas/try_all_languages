
default:
	for i in `ls -F | grep /`; do cd $$i; make ; done

clean:
	rm -rf *~
	for i in `ls -F | grep /`; do cd $$i; make clean ; done

