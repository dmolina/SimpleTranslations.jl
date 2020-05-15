using Documenter, SimpleTranslations

makedocs(;
    modules=[SimpleTranslations],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
        "Tutorial" => "tutorial.md",
        "API" => "api.md",
    ],
    repo="https://github.com/dmolina/SimpleTranslations.jl/blob/{commit}{path}#L{line}",
    sitename="SimpleTranslations.jl",
    authors="Daniel Molina",
)

deploydocs(;
    repo="github.com/dmolina/SimpleTranslations.jl",
)
