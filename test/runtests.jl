using SimpleTranslations
using Test

@testset "SimpleTranslations.jl" begin
    @test_throws ErrorException loadmsgs("notfound.ini")
    conf = loadmsgs("test.ini")
    @test get_msg(conf, "hi") == "Hi"
    set_language!(conf, "es")
    @test get_msg(conf, "hi") == "Hola a todos"
    loadmsgs("test_nostrict1.ini")
    @test_throws ErrorException loadmsgs("test_nostrict1.ini", strict_mode=true)
end

@testset "Usage with files" begin
    fname = joinpath(dirname(pathof(SimpleTranslations)), "..", "test", "test.ini")
    msgs = loadmsgs(fname)
    @test get_msg(msgs, "hi")=="Hi"
end

@testset "Checking strict" begin
    test_not_default = """
default = en

[en]
person=Person

[eo]
person=Homo
"""
    msgs = loadmsgs(IOBuffer(test_not_default), strict_mode=true)
    @test Set(["en", "eo"]) == Set(keys(msgs._msgs))
    @test Set(["en", "eo"]) == Set(msgs._languages)
end

@testset "Checking strict missing language" begin
    test_not_default = """
default = en
language=en,eo,es

[en]
person=Person

[eo]
person=Homo
"""
    @test_throws FileMessagesException msgs = loadmsgs(IOBuffer(test_not_default), strict_mode=true)
end

@testset "Checking strict missing language" begin
    test_not_default = """
default = en
language=en,eo,fr

[en]
person=Person
people=People

[eo]
person=Homo
people=Homoj

[fr]
person=Personne
"""
    @test_throws FileMessagesException msgs = loadmsgs(IOBuffer(test_not_default), strict_mode=true)
end

@testset "Global State" begin
    test_not_default = """
default = en
languages=en,eo,fr

[en]
person=Person
people=People

[eo]
person=Homo
people=Homoj

[fr]
person=Personne
people=Gens
"""
    loadmsgs!(IOBuffer(test_not_default), strict_mode=true)
    @test get_msg("person") == "Person"
    set_language!("fr")
    @test get_msg("person") == "Personne"
    set_language!("eo")
    @test get_msg("person") == "Homo"
    @test msg"person" == "Homo"
end
