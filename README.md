
## About try_all_languages

Its a project to execute programs in many different languages via a REST API. List of supported languages: apl, bash, bqn, c, clojure, cpp, csharp, dc, elixir, fsharp, go, golfscript, haskell, j, java, jelly, julia, k, kotlin, lua, node, ocaml, perl, php, powershell, prolog, python, r, raku, ruby, rust, scala, vyxal, zsh.

A pm2/expressjs server parses the request and launches the right docker image, executes the code and returns the results.

## Docker images

This section details the docker images used to execute code in many different lanugages. There is one docker per image. To build all docker images type:

```
cd docker
bash build_all_docker.sh
```

Here is the achitecture below. Arbbitrary code is executed in a docker. Directories ```dir1``` on host is mounted on ```/mnt/in``` on docker to read input data an source code,
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

To test the REST API from the host machine type
```
make test
```
