default:
	set -e ; for i in `ls -F | grep /`; do cd $$i; echo "testing $$i" ; make >/dev/null 2> /dev/null || (printf "\033[31merror in $$i\033[0m\n"); printf "\033[32mok\033[0m\n" ; cd .. ; done

time:
	echo "" > foo.txt
	for i in `ls -F | grep /`; do cd $$i; echo  "*********"$$i >> ../foo.txt; time -a -o ../foo.txt make >/dev/null 2> /dev/null ; cd .. ; done

clean:
	rm -f *~ 
	for i in `ls -F | grep /`; do cd $$i; make clean ; cd .. ; done

