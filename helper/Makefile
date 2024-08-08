
default:
	for i in `ls -F | grep /`; do cd $$i; make ; cd .. ; done

clean:
	rm -rf *~
	for i in `ls -F | grep /`; do cd $$i; make clean ; cd .. ; done

