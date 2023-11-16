
## About try_all_languages

Its a project to execute programs in many different languages via a REST API. List of supported languages: apl, bash, bqn, c, clojure, cpp, csharp, dc, elixir, fsharp, go, golfscript, haskell, j, java, jelly, julia, k, kotlin, lua, node, ocaml, perl, php, powershell, prolog, python, r, raku, ruby, rust, scala, vyxal, zsh.

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
