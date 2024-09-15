This docker enables to execute [SQL](https://en.wikipedia.org/wiki/SQL). It's also available on [DockerHub](https://hub.docker.com/r/fderepas/tal-sql). Here is how it is meant to be used:

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

Here is a typical usage. Let's create a file ```prog.sql``` containing:
```
SELECT val FROM stdin ORDER BY id;
SELECT val FROM argv ORDER BY id;
```
Let's set standard input by creating file ```input0.txt``` represening standard input containing ```foo``` ```argc_0.txt``` containing 1 and ```argv_0_0.txt``` containing ```bar```.

To executes the sql statement we need to type:
```
docker run \
       --mount type=bind,source=`pwd`,target=/mnt/in,ro \
       --mount type=bind,source=`pwd`,target=/mnt/out \
       --network none \
       --name tal-c-$$ --rm \
       tal-c:latest /bin/sh /home/tal/launch.sh 2
```
For each execution (just 1 in this case) table ```stdin``` is populated with standard input and table ```argv``` is poulated with command line arguments.

```
CREATE DATABASE tal;
USE tal;
CREATE TABLE stdin (
    id INT,
    val text,
    PRIMARY KEY (id)
);
CREATE TABLE argv (
    id INT,
    val text,
    PRIMARY KEY (id)
);
```
The returned info by former docker command is located in file ```out0.txt``` which contains:
```json
{"data":[
  {"code":0,
   "out":"foo%0Abar%0A","err":""}
]}
```
Since no error occurs, an empty ```out0.txt``` file is generated.