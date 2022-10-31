using KM3AcousticsPlots
using Documenter

DocMeta.setdocmeta!(KM3AcousticsPlots, :DocTestSetup, :(using KM3AcousticsPlots); recursive=true)

makedocs(;
    modules=[KM3AcousticsPlots],
    authors="Markus Pirke <markus.pirke@fau.de>",
    repo="https://github.com/mpirke/KM3AcousticsPlots.jl/blob/{commit}{path}#{line}",
    sitename="KM3AcousticsPlots.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://mpirke.github.io/KM3AcousticsPlots.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mpirke/KM3AcousticsPlots.jl",
    devbranch="main",
)
