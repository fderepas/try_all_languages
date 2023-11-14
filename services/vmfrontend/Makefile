default :
	@if [ `which npm | wc -l` -eq 0 ]; then echo 'npm not installed, please install npm.' ; exit 1; fi
	if [ `which pm2 | wc -l` -eq 0 ]; then npm install pm2 ; fi
	mkdir -p data
	node_modules/.bin/pm2 start
install :
	npm install express --save
clean:
	rm -rf data node_modules  package-lock.json package.json
	rm -rf `find . -name \*~`
