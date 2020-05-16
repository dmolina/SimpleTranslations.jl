using SimpleTranslations
using Test

@testset "SimpleTranslations.jl" begin
    @test_throws ErrorException read_messages("notfound.ini")
    conf = read_messages("test.ini")
    @test get_msg(conf, "hi") == "Hi"
    set_language!(conf, "es")
    @test get_msg(conf, "hi") == "Hola a todos"
    read_messages("test_nostrict1.ini")
    @test_throws ErrorException read_messages("test_nostrict1.ini", strict_mode=true)
end

@testset "Usage with files" begin
    fname = joinpath(dirname(pathof(SimpleTranslations)), "..", "test", "test.ini")
    msgs = read_messages(fname)
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
    msgs = read_messages(IOBuffer(test_not_default), strict_mode=true)
    @test Set(["en", "eo"]) == Set(keys(msgs._msgs))
    @test Set(["en", "eo"]) == Set(msgs._languages)
end
