
## About try_all_languages

```try_all_languages``` enables to execute programs in many different languages via a REST API. List of supported languages: 
[Apl](https://en.wikipedia.org/wiki/APL_(programming_language)), 
[Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)),
[Bqn](https://mlochbaum.github.io/BQN/), 
[C](https://en.wikipedia.org/wiki/C_(programming_language)), 
[Clojure](https://en.wikipedia.org/wiki/Clojure), 
[Cobol](https://en.wikipedia.org/wiki/COBOL),
[C++](https://en.wikipedia.org/wiki/C%2B%2B), 
[C#](https://en.wikipedia.org/wiki/C_Sharp_(programming_language)), 
[DC](https://en.wikipedia.org/wiki/Dc_(computer_program)), 
[Elixir](https://en.wikipedia.org/wiki/Elixir_(programming_language)), 
[Elang](https://en.wikipedia.org/wiki/Erlang_(programming_language)) , 
[Fig](https://github.com/Seggan/Fig), 
[Fortran](https://en.wikipedia.org/wiki/Fortran), 
[F#](https://en.wikipedia.org/wiki/F_Sharp_(programming_language)), 
[Go](https://en.wikipedia.org/wiki/Go_(programming_language)), 
[GolfScript](https://esolangs.org/wiki/GolfScript), 
[Haskell](https://en.wikipedia.org/wiki/Haskell), 
[J](https://en.wikipedia.org/wiki/J_(programming_language)), 
[Java](https://en.wikipedia.org/wiki/Java_(programming_language)), 
[Jelly](https://github.com/DennisMitchell/jellylanguage), 
[Julia](https://en.wikipedia.org/wiki/Julia_(programming_language)), 
[K](https://en.wikipedia.org/wiki/K_(programming_language)), 
[Kotlin](https://en.wikipedia.org/wiki/Kotlin_(programming_language)),
[Lisp](https://en.wikipedia.org/wiki/Lisp),
[Logo](https://en.wikipedia.org/wiki/Logo_(programming_language)),
[Lua](https://en.wikipedia.org/wiki/Lua_(programming_language)), 
[NodeJs](https://en.wikipedia.org/wiki/Node.js), 
[Ocaml](https://en.wikipedia.org/wiki/OCaml), 
[Perl](https://en.wikipedia.org/wiki/Perl), 
[PHP](https://en.wikipedia.org/wiki/PHP), 
[PowerShell](https://en.wikipedia.org/wiki/PowerShell), 
[Prolog](https://en.wikipedia.org/wiki/Prolog), 
[Python](https://en.wikipedia.org/wiki/Python), 
[R](https://en.wikipedia.org/wiki/R_(programming_language)), 
[Raku](https://en.wikipedia.org/wiki/Raku_(programming_language)), 
[Ruby](https://en.wikipedia.org/wiki/Ruby_(programming_language)), 
[Rust](https://en.wikipedia.org/wiki/Rust_(programming_language)), 
[Scala](https://en.wikipedia.org/wiki/Scala_(programming_language)), 
[Swift](https://en.wikipedia.org/wiki/Swift_(programming_language)), 
[Vyxal](https://vyxapedia.hyper-neutrino.xyz/), 
[Zsh](https://en.wikipedia.org/wiki/Z_shell). 
The version of runtimes or compilers is given [here](docker/version.json).


Here is an example from the [test.html](rest_api/rest_api_server/public/test.html) page that comes with the rest api server:
![all colors](https://github.com/fderepas/try_all_languages/blob/main/images/screenshot_of_live_web_site.png?raw=true)

You can test it live at [https://t-a-l.org/test.html](https://t-a-l.org/test.html).

## Docker images

Docker images are also available on [DockerHub](https://hub.docker.com/repositories/fderepas).

This section details the docker images used to execute code in many different langages. There is one docker image per language. To build all docker images type:

```
cd docker
make
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

It launches on host a pm2/expressjs server parses the request and launches the right docker image, executes the code and returns the results. Source code is in ```rest_api/rest_api_server```. Tests of the REST API is performed in ```rest_api/rest_api_server_test```.

To test the server in an interactive manner you can try ```/test.html``` on the running pm2 server.

## Container for the REST API

The REST API can be put in a container itself:

```
 +---------------docker/nestybox-----------------+
 |  +----PM2 server---+     +----- docker -----+ |
 |  |                 |---->| execute arbitrary| |
 |  +-----------------+     |    program       | |
 |                          +-/mnt/in--/mnt/out+ |
 |  +-docker registry-+         |         |      |
 |  |                 |        dir1      dir2    |
 |  +-----------------+                          |
 +-----------------------------------------------+
```
Dockers to execute langage do not live for long, just a few seconds.
In order to use in a kubernetes environment we need to put that in a container which lives
for a long period of time. In order to spawn rapidly the images we have a local docker registry.

In order to limit the output of the arbitrary program it's output, stored in ```dir2``` is a file:
```
dd if=/dev/zero of=dir2 bs=1000 count=10000
mkfs.ext3 dir2
```
Then ```dir2``` is mounted as a filesystem by the container executing arbitrary code.
This container has a timeout of 60 seconds.

This container version of the pm2 server is performed in the ```rest_api/rest_api_docker``` directory.

## Time and size
Here is the graph of sorted docker image size per language:

![all colors](https://github.com/fderepas/try_all_languages/blob/main/images/docker_image_size_by_language.png?raw=true)

This image can be generated by typing ```cd docker; make image_size```.

Here is the graph of sorted execution time per language:

![all colors](https://github.com/fderepas/try_all_languages/blob/main/images/docker_time_by_language.png?raw=true)

The test to measure time consists in running 40 times a program which reads 3 lines from stdin and outputs data read. It can be launched by typing ```cd docker; make time```.
