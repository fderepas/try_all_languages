

## Docker images for all languages

## What this directory contains

This directory enables to build each container to execute a source code for a given language. There is one directory per language.

Each docker has the same structure:

```
    +----- docker -----+
    | execute arbitrary|
    |    program       |
    +-/mnt/in--/mnt/out+
        |         |
      dir1      dir2   
```
There is one input directory on the host machine holding the source to execute and standard input for each execution.

The docker compiles the source code if needed. Then the docker executes the program for each standard input in dir1. Each corresponding output is written in dir2.

## Makefile commands

To build all docker images:

```
make
```

To remove useless images:
```
make prune
```

To delete all generated files:
```
make clean
```

To get the size in bytes of all generated images:
```
make size
```
To remove old docker images not used anymore:
```
bash delete_old_img.sh
```

## File structure

Each language directory enables to build a docker image. It contains the following structure.

```
-+ <language name>
 + Dockerfile   commands to create the container
 + Makefile     default commands
 + build.sh     script to build the container
 + launch.sh    script to be copied in the container
 + test         test directory
   + Makefile   how to launch tests
   + test.sh    script to execute tests
 + version.sh   return the version of the language being used

```