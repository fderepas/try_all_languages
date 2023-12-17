default:
	bash build_all_docker.sh

.PHONY:version.json
version.json:
	bash update_version.sh
	cat version.json > ../rest_api/rest_api_server/public/version.json
	git pull && git commit version.json ../rest_api/rest_api_server/public/version.json -m 'updated versions' && git push

prune:
	docker system prune -f

image_size:
	bash generate_size_data_file.sh
	python generate_size_png_file.py || echo -e "Error, install matplotlib:\n    python -m pip install -U pip\n    python -m pip install -U matplotlib"
	mv docker_image_size_by_language.png ../images/
	mv image_size.json ../images/
	git add ../images/docker_image_size_by_language.png ../images/image_size.json
	git commit ../images/docker_image_size_by_language.png ../images/image_size.json -m 'update'
	git pull
	git push

time:
	bash compute_time.sh
	python generate_time_png_file.py || echo -e "Error, install matplotlib:\n    python -m pip install -U pip\n    python -m pip install -U matplotlib"
	mv docker_time_by_language.png ../images/
	mv execution_time.json ../images
	git add ../images/docker_time_by_language.png ../images/execution_time.json
	git commit ../images/docker_time_by_language.png ../images/execution_time.json -m 'update'
	git pull
	git push

clean_images:
	docker rmi -f `docker images | grep ^tal- | tr -s ' ' | cut -d ' ' -f 3 | sort -u`
	docker system prune -f

clean:
	rm -f *~ image_size.json
	for i in `ls -F | grep /`; do cd $$i; make clean ; cd .. ; done

size:
	for i in `docker images --format "{{.Repository}} {{.Tag}}" | grep ^tal- | grep latest | cut -d ' ' -f 1`; do  docker inspect $${i}:latest | jq '.[].Size' ; done  | awk '{s+=$$1} END {print s}'

#	docker images --format "{{.ID}}\t{{.Size}}\t{{.Repository}}\t{{.Tag}}" | sort -k 2 -h | grep latest | grep tal
# added in crontab
# for i in `find /home/tal/tal/docker -name update.sh`; do bash $i; done
