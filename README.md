# SimpleTranslations

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://dmolina.github.io/SimpleTranslations.jl/dev)
[![Build Status](https://travis-ci.com/dmolina/SimpleTranslations.jl.svg?branch=master)](https://travis-ci.com/dmolina/SimpleTranslations.jl)

This package is a simple way to translate the different messages to users
(including the possible error messages) to different languages.

This package raised as a need utility to translate the error messages to users
in different languages without including many dependencies.

The term "Simple** means that the package is not oriented to be a complex system,
but as a simple and easy to use way to translate messages. For instance, in this 
packages all the configuration is in a simple file.
 
**Installation:** at the Julia REPL,
```julia
using Pkg; Pkg.add("SimpleTranslations")
```

## Usage

The usage is simple: 

```
using SimpleTranslations

# Get the messages from a file
messages = loadmsgs("messages.ini")
# Show the message in the default language
println(get_msg(messages, "hi")) # Return "Hi everybody"
# Change the language to spanish 
set_language!(messages, "es")
println(get_msg(messages, "hi")) # Return "Hola a todos"
```

Also, when only one file is used, it can be simpler:

```
using SimpleTranslations

# Get the messages from a file
loadmsgs!("messages.ini")
# Show the message in the default language
println(get_msg("hi")) # Return "Hi everybody"
# Change the language to spanish 
set_language!("es")
println(get_msg("hi")) # Return "Hola a todos"
```

## Advantages 

The advantages of using this package is:

- All the messages are easily changed in a external fine, without changing the
  source code.
  
- Add an additional language is very easy, only add content in the file in text
  mode.
  
- An optional *strict_mode*, in which when the file is loaded, it is checked
  that all messages are translated to all supported languages.
  
## Relative Packages

In order to show the values of variables in the messages, it is recommended to 
use the package [Formatting.jl](https://github.com/JuliaIO/Formatting.jl).

An more powerful and standard way to translate messages is through
[Gettext](https://github.com/Julia-i18n/Gettext.jl) that works on the standards
.po and .mo files. However, this package has several advantages:

- Gettext.jl currently depends on PyCall, so it implies to include many
  dependencies. 
  
- *xgettext* is a great tool to extract messages from source code, but it is
  actually not working in Julia.

- In *SimpleTranslations* the input format is simpler.

- *SimpleTranslations*, at difference of *Gettext*, allows a strict mode, in
  which the is throw an error if a error message is not translated to a language.
