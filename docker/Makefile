default:
	for i in `ls -F | grep / | grep -v ^erlang/$$ | grep -v ^apl/$$ | grep -v ^bqn/$$ | grep -v ^dc/$$ | grep -v haskell | grep -v clojure | grep -v kotlin | grep -v ^k/$$ | grep -v ^j/$$ | grep -v ^r/$$ `; do cd $$i && make &&  cd test && make && cd ../.. ; done

.PHONY:version.json
version.json:
	echo "{" > tmp.json
	for i in `ls -F | grep /`; do cd $$i && n=`echo $$i | tr -d /` && p=`bash version.sh | tr -d '\14' | tr -s '"' "'"` &&  echo "\"$$n\":\"$$p\",">> ../tmp.json ; cd .. ; done
	echo "}" >> tmp.json
	tr -cd '\11\12\40-\176' < tmp.json > version.json
	rm tmp.json
	cat version.json >  ../services/vmfrontend/public/version.json
prune:
	docker system prune -f 
clean:
	rm -f *~ 
	for i in `ls -F | grep /`; do cd $$i; make clean ; cd .. ; done

size:
	for i in `docker images --format "{{.Repository}} {{.Tag}}" | grep ^tal- | grep latest | cut -d ' ' -f 1`; do  docker inspect $${i}:latest | jq '.[].Size' ; done  | awk '{s+=$$1} END {print s}'

#	docker images --format "{{.ID}}\t{{.Size}}\t{{.Repository}}\t{{.Tag}}" | sort -k 2 -h | grep latest | grep tal
# added in crontab
# for i in `find /home/tal/tal/docker -name update.sh`; do bash $i; done
