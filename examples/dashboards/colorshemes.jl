using GLMakie, ColorSchemes, Random
GLMakie.activate!()

function plotVolColormaps(; rseed = 123)
    Random.seed!(rseed)
    ## all colormaps from colorschemes
    cs = collect(keys(colorschemes))
    cmapIdx = Observable(1)
    cmap = @lift(cs[$cmapIdx])
    ## the actual figure
    x = y = z = -1.7:0.05:1.7
    r(i, j, k) = sqrt(i^2 + j^2 + k^2)
    A = [rand() / r(i, j, k)^2 for i in x, j in y, k in z]

    fig = Figure(resolution = (1200, 800))
    ax = Axis3(fig[1, 1];
        aspect = (1, 1, 1),
        perspectiveness = 0.5,
        elevation = π / 9
        )
    volume!(ax, x, y, z, A; colormap = cmap, transparency = true)
    sl = Slider(fig[1, 2], range = 1:length(cs), startvalue = 40, horizontal = false)
    connect!(cmapIdx, sl.value)
    fig[0, 1] = GLMakie.Label(fig, @lift("Colormap: $(cs[$cmapIdx])"), fontsize = 20,
        tellheight = true, tellwidth = false)
    fig
end
fig = with_theme(plotVolColormaps, theme_dark())

# !!! warning 
# This example was autogenerated using:

using Pkg
Pkg.status(["GLMakie", "ColorSchemes"])