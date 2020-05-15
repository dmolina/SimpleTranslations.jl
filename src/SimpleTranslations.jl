module SimpleTranslations

using Parameters

@with_kw mutable struct SimpleTranslation
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
    key, value = parse_msg(line)
    values = strip.(split(value, ","))
    return key, values
end

"""
is_valid(translation)

Check if the translation is perfect, for strict mode.

If any error is detected, an exception is throw
"""
function check_valid(translation::SimpleTranslation)
    langs = Set(keys(translation._msgs))

    if translation._languages != langs
        diff = setdiff(translation._languages, langs)
        if !isempty(diff)
            error("error: languages '$(diff)' are missing")
        end

        diff = setdiff(langs, translation._languages)
        if !isempty(diff)
            error("error: languages '$(diff)' should be in 'languages' options")
        end
    end
end

"""
read_messages(file, strict_mode)

read the file with the message list.

#  Arguments
- `file::IO`: file to get the messages.
- `strict_mode::Bool=false`: strict mode (default=false).
"""
function read_messages(file::IO, strict_mode=false)
    conf = SimpleTranslation()

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
read_messages(filename)

read the file with the message list.

#  Arguments
- `filename::AbstractString`: name of the file to get the messages.
- `strict_mode::Bool=false`: strict mode (default=false).
"""
function read_messages(filename::AbstractString; strict_mode=false)
    conf = SimpleTranslation()

    if ! isfile(filename)
        error("Error, file $(conf.fname) not found")
    end

    open(filename, "r") do file
        conf = read_messages(file, strict_mode)
    end

    return conf
end

"""
set_language!(conf::SimpleTranslation, lang::AbstractString)

update the current language
"""
function set_language!(conf::SimpleTranslation, lang::AbstractString)
    if !(lang in conf._languages)
        error("Error, language '$lang' unknow in file messages")
    end

    conf._language=lang
end


"""
get_msg(conf::SimpleTranslation, id::AbstractString)

return the id message translate to current language
"""
function get_msg(conf::SimpleTranslation, id::AbstractString)
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

export read_messages
export get_msg
export set_language!



end # module
