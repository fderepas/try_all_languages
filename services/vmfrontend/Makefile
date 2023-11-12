default :
	mkdir -p data
	pm2 start
install :
	npm install express --save
clean:
	rm -rf data node_modules  package-lock.json package.json
	rm -rf `find . -name \*~`
