# Tutorial

*SimpleTranslations* is a package to do simple translation through a ini file.


## Syntax

An example of the message file is the following:

```
@raw
[config]
languages=es,fr,en
default=en

[en]
hi=Hi
[es]
hi=Hola a todos
bye=Adios

[fr]
hi=Bonjour
```


## Using a only file 

```@example
using SimpleTranslations

fname = joinpath(dirname(pathof(SimpleTranslations)), "..", "test", "test.ini")
msgs = read_messages(fname)
println(get_msg(msgs, "hi"))
```

## With several files

## More Examples
