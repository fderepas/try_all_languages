This is a version of [Gnu Dc] where some options have been added to ease operations on strings. It is based on Gnu Bc version 1.07. It is the version which currently runs on [tal](https://t-a-l.org/test.html).

# List of new operations

## @

The ```@``` operator reads a line from standard input and pushes it as a string on the stack. I is similar to ```?``` without execution.

Example:
```
$ echo "Hello Word!" | dc -e '@f'
Hello Word!
```

## T

The ```T``` operator splits a string into chars and pushes them on the stack.

Example:
```
$ dc -e '[foobar]Tf'
6
f
o
o
b
a
r
```
## U

When top of the stack is a string, top element is popped, the ascii code of the first character is pushed on the stack.

Example:
```
$ dc -e '[A]Uf'
65
```

## +
The ```+``` operator concatenates the two top elements when they are strings.

Example:
```
$ dc -e '[AB][CD]+f'
ABCD
```

## -
The ```-``` operator concatenates the two top elements when they are strings, in reverse order of ```+```.

Example:
```
$ dc -e '[AB][CD]-f'
CDAB
```

## /
The ```/``` operator splits a string given a separator.

Example:
```
$ dc -e '[ab;cde;fgij][;]/f'
3
ab
cde
fgij
```


[Gnu Dc]: <https://www.gnu.org/software/bc/manual/dc-1.05/html_mono/dc.html>
