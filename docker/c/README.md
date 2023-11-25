This docker enables to execute a source code for a [C](https://en.wikipedia.org/wiki/C_(programming_language)). It's also available on [DockerHub](https://hub.docker.com/r/fderepas/tal-c). Here is how it is meant to be used:

```
    +----- docker -----+
    | execute arbitrary|
    |    program       |
    +-/mnt/in--/mnt/out+
        |         |
      dir1      dir2   
```
There is one input directory on the host machine holding the source to execute and standard input for each execution.

The docker compiles the source code. Then executes the program for each standard input in dir1. Each corresponding output is written in dir2.

Here is a typical usage to launch two executions of ```prog.c``` with standard input ```input0.txt``` and ```input1.txt``` which will produce  associated standard output, standard error, and return codes. For execution ```0``` files ```out0.txt```, ```err0.txt```, and ```errcode0.txt``` are created, for execution ```1``` files ```out1.txt```, ```err1.txt```, and ```errcode1.txt``` are created. For instance associated command line to launch docker with current directory for input and output is:
```
docker run \
       --mount type=bind,source=`pwd`,target=/mnt/in,ro \
       --mount type=bind,source=`pwd`,target=/mnt/out \
       --network none \
       --name tal-c-$$ --rm \
       tal-c:latest /bin/sh /home/tal/launch.sh 2
```