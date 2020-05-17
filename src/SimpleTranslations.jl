module SimpleTranslations

using Parameters
using Formatting

@with_kw mutable struct MessagesTranslator
    _msgs::Dict{String,Dict{String,String}}=Dict()
    _languages::Set{String}=Set()
    _default::String=""
    _language::String=""
    _strict_mode::Bool=false
end

struct FileMessagesException <: Exception
    line::String
end

struct MessageMissing <: Exception
    msg::String
    lang::String
end

Base.showerror(io::IO, e::FileMessagesException) = print(io, "Error: line '$(e.line)' has not good format")
Base.showerror(io::IO, e::MessageMissing) = print(io, "Error: msg '$(e.msg)' is not translated to '$(e.lang)'")

"""
parse_msg

Parse the message separate the key, value by "="
"""
function parse_msg(line)
    if !occursin("=", line)
        throw(FileMessagesException(line))
    end

    key, value = split(line, "=")
    return key, value
end

"""
parse_option(line)

Parse the option, separated the values by ","
"""
function parse_option(line)
    key, value = strip.(parse_msg(line))
    values = strip.(split(value, ","))
    return key, values
end

function check_sets(set1, set2, template1, template2)
    diff = setdiff(set1, set2)
    if !isempty(diff)
        error("error: " *format(template1, first(diff)))
    end

    diff = setdiff(set2, set1)
    if !isempty(diff)
        error("error: " *format(template2, first(diff)))
    end
end

"""
is_valid(translation)

Check if the translation is perfect, for strict mode.

If any error is detected, an exception is throw
"""
function check_valid(translation::MessagesTranslator)
    langs = Set(keys(translation._msgs))

    check_sets(translation._languages, langs, "languages {} are missing", "languages {} show be in 'languages' options")

    # Check the parameters
    ids = map(keys, values(translation._msgs))

    if isempty(ids)
        error("Error: not messages")
    end

    ref = Set(keys(translation._msgs[translation._default]))

    for (lang,msgs) in pairs(translation._msgs)
        ids_lang = keys(msgs)

        check_sets(Set(ids_lang), ref, "ids '{1:s}' not defined in default language '$(translation._default)'",
                   "ids '{1:s}' not defined in language '$(lang)'")
    end
end

"""
loadmsgs(file, strict_mode)

read the file with the message list.

#  Arguments
- `file::IO`: file to get the messages.
- `strict_mode::Bool=false`: strict mode (default=false).
"""
function loadmsgs(file::IO; strict_mode=false)
    conf = MessagesTranslator()

    languages = Set{String}()
    category = "config"

    for line in readlines(file)
        line = strip(line)

        if isempty(line)
            continue
        end

        # If it is category
        if occursin(r"^\[\w*\]$", line)
            category = line[2:end-1]
            if category != "config"
                conf._msgs[category] = Dict{String,String}()
            end
            # Normal line
        elseif category == "config"
            key, val = parse_option(line)

            if key == "languages"
                conf._languages = Set(val)
            elseif key == "default"
                conf._default = only(val)
                # Unknow parameter
            else
                throw(FileMessagesException(line))
            end
            # Message
        else
            key, val = parse_msg(line)
            conf._msgs[category][key] = val
        end
    end
    if isempty(conf._languages)
        conf._languages = Set(keys(conf._msgs))
    end

    if (strict_mode)
        check_valid(conf)
        conf._strict_mode = strict_mode
    end

    conf._language = conf._default
    return conf
end

"""
loadmsgs(filename)

read the file with the message list.

#  Arguments
- `filename::AbstractString`: name of the file to get the messages.
- `strict_mode::Bool=false`: strict mode (default=false).
"""
function loadmsgs(filename::AbstractString; strict_mode=false)
    conf = MessagesTranslator()

    if ! isfile(filename)
        error("Error, file $(filename) not found")
    end

    open(filename, "r") do file
        conf = loadmsgs(file, strict_mode=strict_mode)
    end

    return conf
end

"""
set_language!(conf::MessagesTranslator, lang::AbstractString)

update the current language
"""
function set_language!(conf::MessagesTranslator, lang::AbstractString)
    if !(lang in conf._languages)
        error("Error, language '$lang' unknow in file messages")
    end

    conf._language=lang
end


"""
get_msg(conf::MessagesTranslator, id::AbstractString)

return the id message translate to current language
"""
function get_msg(conf::MessagesTranslator, id::AbstractString)
    if !haskey(conf._msgs, conf._language)
        throw(MessageMissing(id, conf._language))
    end
    lang_msgs = conf._msgs[conf._language]
    default_msgs = conf._msgs[conf._default]

    if (haskey(lang_msgs, id))
        return lang_msgs[id]
    elseif conf._strict_mode
        throw(MessageMissing(id, conf._language))
    elseif(haskey(default_msgs, id))
        return default_msgs[id]
    else
        throw(MessageMissing(id, conf._default))
    end
end


const _global_msgs = MessagesTranslator()

"""
loadmsgs!(file; strict_mode=false)

Load the messages in a global variable.

#  Arguments
- `file::IO`: file to get the messages.
- `strict_mode::Bool=false`: strict mode (default=false).

@ref loadmsgs

# Example

@example loadmsgs!("test/test.ini")
"""
function loadmsgs!(file; strict_mode=false)
    global _global_msgs
    msgs = loadmsgs(file, strict_mode=strict_mode)
    _global_msgs._msgs = msgs._msgs
    _global_msgs._language = msgs._language
    _global_msgs._languages = msgs._languages
    _global_msgs._default = msgs._default
    _global_msgs._strict_mode = msgs._strict_mode
    return nothing
end

"""
set_language!(lang)

Set the language to lang in future messages.

# Arguments lang language identification.

# Example

```
set_language!("es")
```
"""
function set_language!(lang)
    global _global_msgs
    set_language!(_global_msgs, lang)
    return nothing
end

"""
Get the translated message in the global Translater

# Arguments
- id: identificator of the message.
"""
function get_msg(id::AbstractString)
    global _global_msgs
    return get_msg(_global_msgs, id)
end

macro msg_str(id)
    global _global_msgs
    return get_msg(_global_msgs, id)
end

export loadmsgs
export loadmsgs!
export get_msg
export set_language!

export FileMessagesException
export MessageMissing
export @msg_str

end # module
