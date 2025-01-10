using AcceleratorSimUtils
using Documenter

DocMeta.setdocmeta!(AcceleratorSimUtils, :DocTestSetup, :(using AcceleratorSimUtils); recursive=true)

makedocs(;
    modules=[AcceleratorSimUtils],
    authors="DavidSagan <dcs16@cornell.edu> and contributors",
    sitename="AcceleratorSimUtils.jl",
    format=Documenter.HTML(;
        canonical="https://bmad-sim.github.io/AcceleratorSimUtils.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/bmad-sim/AcceleratorSimUtils.jl",
    devbranch="main",
)
