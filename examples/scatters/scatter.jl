using CairoMakie, Distributions
using Random
CairoMakie.activate!(type = "svg") #hide
Random.seed!(1234)
d = Normal()
b = Binomial(15, 0.7)
n = 350
scatter(rand(d,n), rand(b, n);
    markersize = 12*abs.(rand(d, n)),
    color = tuple.(:orangered, rand(n)),
    strokewidth = 0.5, 
    strokecolor = :white,
    axis = (;
        xlabel = "x", ylabel = "y"), 
    figure = (;
        resolution = (600,400))
    );

save("scatter.svg", current_figure()); # hide

# ![](scatter.svg)

# !!! warning 
# This example was autogenerated using:

using Pkg
Pkg.status(["CairoMakie", "Distributions"])