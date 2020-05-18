var documenterSearchIndex = {"docs":
[{"location":"api/#Index-1","page":"API","title":"Index","text":"","category":"section"},{"location":"api/#","page":"API","title":"API","text":"","category":"page"},{"location":"api/#","page":"API","title":"API","text":"Modules = [SimpleTranslations]","category":"page"},{"location":"api/#SimpleTranslations.get_language-Tuple{SimpleTranslations.MessagesTranslator}","page":"API","title":"SimpleTranslations.get_language","text":"get_language(conf)\n\nReturn the current language of the MessagesTranslator\n\nArguments\n\nconf MessagesTranslator\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.get_language-Tuple{}","page":"API","title":"SimpleTranslations.get_language","text":"get_language()\n\nReturn the language of the current global MessagesTranslator\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.get_msg-Tuple{AbstractString}","page":"API","title":"SimpleTranslations.get_msg","text":"Get the translated message in the global Translater\n\nArguments\n\nid: identificator of the message.\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.get_msg-Tuple{SimpleTranslations.MessagesTranslator,AbstractString}","page":"API","title":"SimpleTranslations.get_msg","text":"get_msg(conf::MessagesTranslator, id::AbstractString)\n\nreturn the id message translate to current language\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.loadmsgs!-Tuple{Any}","page":"API","title":"SimpleTranslations.loadmsgs!","text":"loadmsgs!(file; strict_mode=false)\n\nLoad the messages in a global variable.\n\nArguments\n\nfile::IO: file to get the messages.\nstrict_mode::Bool=false: strict mode (default=false).\n\n@ref loadmsgs\n\nExample\n\n@example loadmsgs!(\"test/test.ini\")\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.loadmsgs-Tuple{AbstractString}","page":"API","title":"SimpleTranslations.loadmsgs","text":"loadmsgs(filename; strict_mode=false)\n\nread the file with the message list.\n\nArguments\n\nfilename::AbstractString: name of the file to get the messages.\nstrict_mode::Bool=false: strict mode (default=false).\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.loadmsgs-Tuple{IO}","page":"API","title":"SimpleTranslations.loadmsgs","text":"loadmsgs(file, strict_mode)\n\nread the file with the message list.\n\nArguments\n\nfile::IO: file to get the messages.\nstrict_mode::Bool=false: strict mode (default=false).\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.set_language!-Tuple{Any}","page":"API","title":"SimpleTranslations.set_language!","text":"set_language!(lang)\n\nSet the language to lang in future messages.\n\nArguments lang language identification.\n\nExample\n\nset_language!(\"es\")\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.set_language!-Tuple{SimpleTranslations.MessagesTranslator,AbstractString}","page":"API","title":"SimpleTranslations.set_language!","text":"set_language!(conf::MessagesTranslator, lang::AbstractString)\n\nupdate the current language\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.check_valid-Tuple{SimpleTranslations.MessagesTranslator}","page":"API","title":"SimpleTranslations.check_valid","text":"is_valid(translation)\n\nCheck if the translation is perfect, for strict mode.\n\nIf any error is detected, an exception is throw\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.parse_msg-Tuple{Any}","page":"API","title":"SimpleTranslations.parse_msg","text":"parse_msg\n\nParse the message separate the key, value by \"=\"\n\n\n\n\n\n","category":"method"},{"location":"api/#SimpleTranslations.parse_option-Tuple{Any}","page":"API","title":"SimpleTranslations.parse_option","text":"parse_option(line)\n\nParse the option, separated the values by \",\"\n\n\n\n\n\n","category":"method"},{"location":"#SimpleTranslations.jl-1","page":"Home","title":"SimpleTranslations.jl","text":"","category":"section"},{"location":"#About-this-package-1","page":"Home","title":"About this package","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"This package is a simple way to translate the different messages to users (including the possible error messages) to different languages.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"This package raised as a need utility to translate the error messages to users in different languages without including many dependencies.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"The term \"Simple\" means that the package is not oriented to be a complex system, but as a simple and easy to use way to translate messages. For instance, in this  packages all the configuration is in a simple file.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"The usage is simple: ","category":"page"},{"location":"#","page":"Home","title":"Home","text":"using SimpleTranslations\n\n# Get the messages from a file\nmessages = loadmsgs(\"messages.ini\")\n# Show the message in the default language\nprintln(get_msg(messages, \"hi\")) # Return \"Hi everybody\"\n# Change the language to spanish \nset_language!(\"es\")\nprintln(get_msg(messages, \"hi\")) # Return \"Hola a todos\"","category":"page"},{"location":"#Advantages-1","page":"Home","title":"Advantages","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"The advantages of using this package is:","category":"page"},{"location":"#","page":"Home","title":"Home","text":"All the messages are easily changed in a external fine, without changing the source code.\nAdd an additional language is very easy, only add content in the file in text mode.\nAn optional strict_mode, in which when the file is loaded, it is checked that all messages are translated to all supported languages.","category":"page"},{"location":"#Relative-Packages-1","page":"Home","title":"Relative Packages","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"In order to show the values of variables in the messages, it is recommended to  use the package Formatting.jl.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"An more powerful and standard way to translate messages is through Gettext that works on the standards .po and .mo files. However, this package has several advantages:","category":"page"},{"location":"#","page":"Home","title":"Home","text":"Gettext.jl currently depends on PyCall, so it implies to include many dependencies. \nxgettext is a great tool to extract messages from source code, but it is actually not working in Julia.\nIn SimpleTranslations the input format is simpler.\nSimpleTranslations, at difference of Gettext, allows a strict mode, in which the is throw an error if a error message is not translated to a language.","category":"page"},{"location":"tutorial/#Tutorial-1","page":"Tutorial","title":"Tutorial","text":"","category":"section"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"SimpleTranslations is a package to do simple translation through a ini file.","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"The usage is simple. ","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"In a .ini file, there are described the different messages for different languages.\nIt is selected the language to which the messages should be translated. If there was not selected any, the default language is selected. \nThe get_msg is used.","category":"page"},{"location":"tutorial/#Syntax-1","page":"Tutorial","title":"Syntax","text":"","category":"section"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"An example of the message file is the following:","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"[config]\nlanguages=es,fr,en\ndefault=en\n\n[en]\nhi=Hi\n[es]\nhi=Hola a todos\nbye=Adios\n\n[fr]\nhi=Bonjour","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"The file contains two type of sections:","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"Section config\nSection for each language","category":"page"},{"location":"tutorial/#Section-config-1","page":"Tutorial","title":"Section config","text":"","category":"section"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"This section is special, and it is the section by default, it contains two variables:","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"languages: List of languages in the file, optional.\ndefault: Language by default.","category":"page"},{"location":"tutorial/#Section-for-each-language-1","page":"Tutorial","title":"Section for each language","text":"","category":"section"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"The other sections contains the translations of each message to a specific language. The name of the section is the language name. ","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"This section is composed by several lines with the format id=message, in which id is the identification of the message using in the source code, and message is the message translated. Not quotation marks are required. The initial and final spaces in id and message are ignored, but the spaces in the middle of the messages are maintained.","category":"page"},{"location":"tutorial/#Usage-1","page":"Tutorial","title":"Usage","text":"","category":"section"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"This package can be used saving the messages in a MessagesTranslator variable, with the function loadmsgs. This function can be used with the filename of with the file already open. Later, the function get_msg is used to receive, from an id of a message, the translation. The language is selected through set_languages, when none is indicated, a default language (indicated in the file) is chosen.","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"loadmsgs\nset_language!\nget_msg","category":"page"},{"location":"tutorial/#SimpleTranslations.loadmsgs","page":"Tutorial","title":"SimpleTranslations.loadmsgs","text":"loadmsgs(file, strict_mode)\n\nread the file with the message list.\n\nArguments\n\nfile::IO: file to get the messages.\nstrict_mode::Bool=false: strict mode (default=false).\n\n\n\n\n\nloadmsgs(filename; strict_mode=false)\n\nread the file with the message list.\n\nArguments\n\nfilename::AbstractString: name of the file to get the messages.\nstrict_mode::Bool=false: strict mode (default=false).\n\n\n\n\n\n","category":"function"},{"location":"tutorial/#SimpleTranslations.set_language!","page":"Tutorial","title":"SimpleTranslations.set_language!","text":"set_language!(conf::MessagesTranslator, lang::AbstractString)\n\nupdate the current language\n\n\n\n\n\nset_language!(lang)\n\nSet the language to lang in future messages.\n\nArguments lang language identification.\n\nExample\n\nset_language!(\"es\")\n\n\n\n\n\n","category":"function"},{"location":"tutorial/#SimpleTranslations.get_msg","page":"Tutorial","title":"SimpleTranslations.get_msg","text":"get_msg(conf::MessagesTranslator, id::AbstractString)\n\nreturn the id message translate to current language\n\n\n\n\n\nGet the translated message in the global Translater\n\nArguments\n\nid: identificator of the message.\n\n\n\n\n\n","category":"function"},{"location":"tutorial/#Example-1","page":"Tutorial","title":"Example","text":"","category":"section"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"using SimpleTranslations\n\nfname = joinpath(dirname(pathof(SimpleTranslations)), \"..\", \"test\", \"test.ini\")\nmsgs = loadmsgs(fname)\nprintln(get_msg(msgs, \"hi\"))\nset_language!(msgs, \"es\")\nprintln(get_msg(msgs, \"hi\"))\nset_language!(msgs, \"fr\")\nprintln(get_msg(msgs, \"hi\"))","category":"page"},{"location":"tutorial/#With-global-information-1","page":"Tutorial","title":"With global information","text":"","category":"section"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"With the previous mechanism, in order to translate any message, the MessagesTranslator should be passed through the different functions calls. ","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"To simplify the usage, there is another way to use the function, inspired in the  Random module in the standard library, in which there are two versions of each function, one with the random generator, and another without the random generator (in that case a global variable is automatically used).","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"using SimpleTranslations\n\nfname = joinpath(dirname(pathof(SimpleTranslations)), \"..\", \"test\", \"test.ini\")\nloadmsgs!(fname)\nprintln(get_msg(\"hi\")) # Hi\nset_language!(\"es\")\nprintln(get_msg(\"hi\")) # Hola a todos\nset_language!(\"fr\")\nprintln(get_msg(\"hi\")) # Bonjour","category":"page"},{"location":"tutorial/#Strict-mode-1","page":"Tutorial","title":"Strict mode","text":"","category":"section"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"In order to have a better control of the messages in the different languages, this module has a strict mode, that can be indicated when the loadmsgs is used. ","category":"page"},{"location":"tutorial/#","page":"Tutorial","title":"Tutorial","text":"In this strict mode, it is automatically checked that all messages are available in all languages, and that there are translations to all languages indicated in languages option.","category":"page"}]
}
