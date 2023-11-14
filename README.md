
## About try_all_languages

Its a project to execute programs in many different languages via a REST API.

A pm2/expressjs server parses the request and launches the right docker image, executes the code and returns the results.

## Docker images

To build all docker images

```
cd doker
bash build_all_docker.sh
```

## To test the REST API

```
make test
```
