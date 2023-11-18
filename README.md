
## About try_all_languages

Its a project to execute programs in many different languages via a REST API. List of supported languages: apl, bash, bqn, c, clojure, cpp, csharp, dc, elixir, fsharp, go, golfscript, haskell, j, java, jelly, julia, k, kotlin, lua, node, ocaml, perl, php, powershell, prolog, python, r, raku, ruby, rust, scala, vyxal, zsh.

## Docker images

This section details the docker images used to execute code in many different lanugages. There is one docker per image. To build all docker images type:

```
cd docker
bash build_all_docker.sh
```

Here is the achitecture below. Arbitrary code is executed in a docker. Directories ```dir1``` on host is mounted on ```/mnt/in``` on docker to read input data an source code,
and ```/mnt/out``` is used to write program output and is maped on ```dir2``` on host.

```
    +----- docker -----+
    | execute arbitrary|
    |    program       |
    +-/mnt/in--/mnt/out+
        |         |
      dir1      dir2   
```

## To test the REST API

To test the REST API from the host machine type in the root of the git repo:
```
make test
```

It launches on host a pm2/expressjs server parses the request and launches the right docker image, executes the code and returns the results. Source code is in ```services/vmfrontend```. Tests of the REST API is performed in ```services/vmfrontend_test```.

## Container for the REST API

The REST API can be put in a container itself:

```
 +---------------docker/nestybox-----------------+
 |                          +----- docker -----+ |
 |  +----PM2 server---+     | execute arbitrary| |
 |  |                 |---->|    program       | |
 |  +-----------------+     +-/mnt/in--/mnt/out+ |
 |  +-docker registry-+         |         |      |
 |  |                 |        dir1      dir2    |
 |  +-----------------+                          |
 +-----------------------------------------------+
```
Dockers to execute langage do not live for long, just a few seconds.
In order to use in a kuibernetes environment we need to put that in a container which lives
for a long period of time. I order to spawn rapidly the images we have a local docker registry.
