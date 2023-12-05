default:
	bash build_all_docker.sh
#	for i in `ls -F | grep / | grep -v ^erlang/$$ | grep -v ^apl/$$ | grep -v ^bqn/$$ | grep -v ^dc/$$ | grep -v haskell | grep -v clojure | grep -v kotlin | grep -v ^k/$$ | grep -v ^j/$$ | grep -v ^r/$$ `; do cd $$i && make &&  cd test && make && cd ../.. ; done

.PHONY:version.json
version.json:
	echo "{" > tmp.json
	for i in `ls -F | grep /`; do echo $$i ; cd $$i && n=`echo $$i | tr -d /` && p=`bash version.sh | tr -d '\14' | tr -s '"' "'" | tr -d '\n' ` &&  echo "\"$$n\":\"$$p\",">> ../tmp.json ; cd .. ; done
	echo "}" >> tmp.json
	tr -cd '\11\12\40-\176' < tmp.json > version.json
	rm tmp.json
	cat version.json > ../rest_api/rest_api_server/public/version.json
	git pull && git commit version.json ../rest_api/rest_api_server/public/version.json -m 'updated versions' && git push

prune:
	docker system prune -f

image_size:
	bash generate_size_data_file.sh
	python generate_size_png_file.py
	mv docker_image_size_by_language.png ../images/
	rm image_size.json
time:
	bash compute_time.sh
	python generate_time_png_file.py
	mv docker_time_by_language.png ../images/
	rm execution_time.json

clean:
	rm -f *~ image_size.json
	for i in `ls -F | grep /`; do cd $$i; make clean ; cd .. ; done

size:
	for i in `docker images --format "{{.Repository}} {{.Tag}}" | grep ^tal- | grep latest | cut -d ' ' -f 1`; do  docker inspect $${i}:latest | jq '.[].Size' ; done  | awk '{s+=$$1} END {print s}'

#	docker images --format "{{.ID}}\t{{.Size}}\t{{.Repository}}\t{{.Tag}}" | sort -k 2 -h | grep latest | grep tal
# added in crontab
# for i in `find /home/tal/tal/docker -name update.sh`; do bash $i; done
