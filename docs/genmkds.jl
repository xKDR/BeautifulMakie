using Documenter, DocumenterMarkdown
using Literate

get_example_path(p) = joinpath(@__DIR__, "..", "examples", p)
OUTPUT = joinpath(@__DIR__, "src", "examples", "generated")

folders = readdir(joinpath(@__DIR__, "..", "examples"))
setdiff!(folders, [".DS_Store"])
#setdiff!(folders, ["bars"])
setdiff!(folders, ["cheat_sheets"])

function getfiles()
    srcsfiles = []
    for f in folders
        names = readdir(joinpath(@__DIR__, "..", "examples", f))
        setdiff!(names, [".DS_Store", "density_ridges.jl",
            "world_energy.jl", "gapminder.jl", 
            "vertical_feature_mask.jl",
            "submarine_cables.jl",
            "timeseries_proj.jl"])
            
        fpaths  = "$(f)/" .* names
        srcsfiles = vcat(srcsfiles, fpaths...)
    end
    return srcsfiles
end

srcsfiles = getfiles()

for (d, paths) in (("2d", srcsfiles),)
    for p in paths
    Literate.markdown(get_example_path(p), joinpath(OUTPUT, d, dirname(p));
            documenter=true)
    end
end