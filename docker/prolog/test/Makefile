default:
	bash test.sh
	for i in `ls -F . | grep ^nr`; do echo $$i; cd $$i; make > /dev/null; cd ..; done
	i=`find . -name input\*.txt | wc -l` && printf "\033[32mall $$i tests ok.\033[0m\n"  

clean:
	rm -f *~ *.txt prog.prolog
	for i in `ls -F . | grep ^nr`; do echo $$i; cd $$i; make clean; cd ..; done

