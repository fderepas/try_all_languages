<<<<<<< HEAD
default : install
=======
default :
	@if [ `which npm | wc -l` -eq 0 ]; then echo 'npm not installed, please install npm.' ; exit 1; fi
	if [ ! -e node_modules/.bin/pm2 ]; then npm install pm2 ; fi
>>>>>>> ca8859e (added local pm2 install)
	mkdir -p data
	node_modules/.bin/pm2 start
install :
	@if [ `which npm | wc -l` -eq 0 ]; then echo 'npm not installed, please install npm.' ; exit 1; fi
	@npm install express > /dev/null 2> /dev/null
	@if [ ! -e ./node_modules/.bin/pm2 ]; then npm install pm2 ; fi
	@if [ ! -d node_modules ]; then npm install express --save; fi
stop: install
	./node_modules/.bin/pm2 stop all
restart: install
	./node_modules/.bin/pm2 restart all
start: install
	./node_modules/.bin/pm2 start all
status: install
	./node_modules/.bin/pm2 status
list: install
	./node_modules/.bin/pm2 list
logs: install
	./node_modules/.bin/pm2 logs
clean:
	rm -rf data node_modules  package-lock.json package.json
	rm -rf `find . -name \*~`
