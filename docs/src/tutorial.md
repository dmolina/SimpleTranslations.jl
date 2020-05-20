# Tutorial

*SimpleTranslations* is a package to do simple translation through a ini file.

The usage is simple. 

1. In a .ini file, there are described the different messages for different languages.

2. It is selected the language to which the messages should be translated. If
   there was not selected any, the default language is selected. 
   
3. The get_msg is used.

## Syntax

An example of the message file is the following:

```
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

The file contains two type of sections:

- [Section config](@ref)
- [Section for each language](@ref)

### Section config

This section is special, and it is the section by default, it contains two
variables:

- languages: List of languages in the file, optional.
- default: Language by default.

### Section for each language

The other sections contains the translations of each message to a specific
language. The name of the section is the language name. 

This section is composed by several lines with the format *id=message*, in which
*id* is the identification of the message using in the source code, and
*message* is the message translated. Not quotation marks are required. The
initial and final spaces in *id* and *message* are ignored, but the spaces in
the middle of the messages are maintained.

# Usage

This package can be used saving the messages in a *MessagesTranslator* variable,
with the function *loadmsgs*. This function can be used with the filename of
with the file already open. Later, the function *get_msg* is used to receive,
from an id of a message, the translation. The language is selected through
*set_languages*, when none is indicated, a default language (indicated in
the file) is chosen.

```@docs
loadmsgs
set_language!
get_msg
```

## Example

```@example
using SimpleTranslations

fname = joinpath(dirname(pathof(SimpleTranslations)), "..", "test", "test.ini")
msgs = loadmsgs(fname)
println(get_msg(msgs, "hi"))
set_language!(msgs, "es")
println(get_msg(msgs, "hi"))
set_language!(msgs, "fr")
println(get_msg(msgs, "hi"))
```

## With global information

With the previous mechanism, in order to translate any message, the
*MessagesTranslator* should be passed through the different functions calls. 

To simplify the usage, there is another way to use the function, inspired in the 
*Random* module in the standard library, in which there are two versions of each
function, one with the random generator, and another without the random
generator (in that case a global variable is automatically used).

```@example
using SimpleTranslations

fname = joinpath(dirname(pathof(SimpleTranslations)), "..", "test", "test.ini")
loadmsgs!(fname)
println(get_msg("hi")) # Hi
set_language!("es")
println(get_msg("hi")) # Hola a todos
set_language!("fr")
println(get_msg("hi"))
 # Bonjour
```
## Strict mode

In order to have a better control of the messages in the different languages,
this module has a strict mode, that can be indicated when the loadmsgs is used. 

In this strict mode, it is automatically checked that all messages are available
in all languages, and that there are translations to all languages indicated in
*languages* option.
