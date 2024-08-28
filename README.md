
## About try_all_languages

```try_all_languages``` enables to execute programs in many different languages via a REST API. List of supported languages: 
[Ada](https://en.wikipedia.org/wiki/Ada_(programming_language)), 
[Apl](https://en.wikipedia.org/wiki/APL_(programming_language)), 
[Assembler (gas)](https://en.wikipedia.org/wiki/GNU_Assembler),
[Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)),
[Bqn](https://mlochbaum.github.io/BQN/), 
[C](https://en.wikipedia.org/wiki/C_(programming_language)), 
[Clojure](https://en.wikipedia.org/wiki/Clojure), 
[Cobol](https://en.wikipedia.org/wiki/COBOL),
[C++](https://en.wikipedia.org/wiki/C%2B%2B), 
[C#](https://en.wikipedia.org/wiki/C_Sharp_(programming_language)), 
[Dart](https://en.wikipedia.org/wiki/Dart_(programming_language)),
[DC](https://en.wikipedia.org/wiki/Dc_(computer_program)), 
[Elixir](https://en.wikipedia.org/wiki/Elixir_(programming_language)), 
[Elang](https://en.wikipedia.org/wiki/Erlang_(programming_language)) , 
[Fig](https://github.com/Seggan/Fig), 
[Fortran](https://en.wikipedia.org/wiki/Fortran), 
[F#](https://en.wikipedia.org/wiki/F_Sharp_(programming_language)), 
[Go](https://en.wikipedia.org/wiki/Go_(programming_language)), 
[GolfScript](https://esolangs.org/wiki/GolfScript),
[Groovy](https://en.wikipedia.org/wiki/Apache_Groovy), 
[Haskell](https://en.wikipedia.org/wiki/Haskell), 
[J](https://en.wikipedia.org/wiki/J_(programming_language)), 
[Java](https://en.wikipedia.org/wiki/Java_(programming_language)), 
[Jelly](https://github.com/DennisMitchell/jellylanguage), 
[Julia](https://en.wikipedia.org/wiki/Julia_(programming_language)), 
[K](https://en.wikipedia.org/wiki/K_(programming_language)), 
[Kotlin](https://en.wikipedia.org/wiki/Kotlin_(programming_language)),
[Lisp](https://en.wikipedia.org/wiki/Lisp_(programming_language)),
[Logo](https://en.wikipedia.org/wiki/Logo_(programming_language)),
[Lua](https://en.wikipedia.org/wiki/Lua_(programming_language)), 
[NodeJs](https://en.wikipedia.org/wiki/Node.js), 
[Ocaml](https://en.wikipedia.org/wiki/OCaml), 
[Perl](https://en.wikipedia.org/wiki/Perl), 
[PHP](https://en.wikipedia.org/wiki/PHP), 
[Postscript](https://en.wikipedia.org/wiki/PostScript), 
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
The version of runtimes or compilers is given [here](https://t-a-l.org/version.json).


Here is an example from the [index.html](rest_api/rest_api_server/public/index.html) page that comes with the rest api server:
![all colors](https://github.com/fderepas/try_all_languages/blob/main/images/screenshot_of_live_web_site.png?raw=true)

You can test it live at [https://t-a-l.org](https://t-a-l.org).

## REST API example

Here is an example of the usage of the REST API. Let's consider the following C program:

```c
#include <unistd.h>
#include <stdio.h>

int main(int argc,char** argv) {
    if (argc>1) {
        // display arguments
        while (*(++argv))
            printf("%s\n",*argv);
    } else {
        // display stdin on stdout
        char buf[1000];
        int c;
        while ((c=read(0,buf,1000))>0) 
            write(1,buf,c);
    }
    return 0;
}
```
It can be compiled and executed using the following URL:
```http
https://t-a-l.org/api/?lang=c&countInput=2&code=%23include%20%3Cunistd.h%3E%0A%23include%20%3Cstdio.h%3E%0A%0Aint%20main(int%20argc%2Cchar**%20argv)%20%7B%0A%20%20%20%20if%20(argc%3E1)%20%7B%0A%20%20%20%20%20%20%20%20%2F%2F%20display%20arguments%0A%20%20%20%20%20%20%20%20while%20(*(%2B%2Bargv))%20printf(%22%25s%5Cn%22%2C*argv)%3B%0A%20%20%20%20%7D%20else%20%7B%0A%20%20%20%20%20%20%20%20%2F%2F%20display%20stdin%20on%20stdout%0A%20%20%20%20%20%20%20%20char%20buf%5B1000%5D%3B%0A%20%20%20%20%20%20%20%20int%20c%3B%0A%20%20%20%20%20%20%20%20while%20((c%3Dread(0%2Cbuf%2C1000))%3E0)%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20write(1%2Cbuf%2Cc)%3B%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%20%20%20return%200%3B%0A%7D%0A&input0=%0A&input1=4300%0A6389%0A1425%0A&argc_0=2&argv_0_0=foo&argv_0_1=bar
```
Here is the meaning of the different parameters in the query string:

- ```lang``` the source code language, in this example the value is "c". The ```lang``` variable should have one of the following value: ada, apl, assembly, bash, bqn, c, clojure, cobol, cpp, csharp, dart, dc, elixir, erlang, fig, fortran, fsharp, go, golfscript, groovy, haskell, j, java, jelly, julia, k, kotlin, lisp, logo, lua, node, ocaml, perl, php, postscript, powershell, prolog, python, r, raku, ruby, rust, sass, scala, typescript, swift, vyxal, zsh.
- ```countInput``` number of tests to perform (two in this example).
- ```code``` the url encoded version of the source code.
- ```intput0``` url encoded version of standard input for test 1.
- ```intput1``` url encoded version of standard input for test 2.
- ```argc_0``` number of extra command line arguments for test 1.
- ```argv_0_0``` value of first argument for test 1.
- ```argv_0_1``` value of second argument for test 1.

Returned value is the following json file:
```json
{
  "data": [
    {"code":0,"out":"foo%0Abar%0A","err":""},
    {"code":0,"out":"4300%0A6389%0A1425%0A","err":""}
  ]
}
```
It has a single ```data``` field holding an array of results for each execution. For each execution the return code, url encoded value of standard output and standard error stream are shown.
## Docker images

Docker images are also available on [DockerHub](https://hub.docker.com/u/fderepas).

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

The test to measure time in seconds consists in running 10 times the launch of a docker image that compiles (for compiled languages) and runs 10 times a program which reads 3 lines from stdin and outputs data read. Displayed result is the average time for launching the docker and performing 10 runs. The computation of the image can be launched by typing ```cd docker; make time```. The fact that lisp or logo are faster than C just means that the packaging in the container is faster with lisp or logo than C compilation plus C runtime. The test program is incredibly simple which does not favor fast languages that require compilation.
