"""
    Written by:satoshi
    Created At:2026年(令和8)10月12日
"""

#import Pkg; Pkg.add("Plots")
#import Pkg; Pkg.add("LaTeXStrings")
using Plots
using LaTeXStrings

## TODO: Get estimate vector (example) to plot

#display(plot(...))
#savefig("name.png") or savefig(plot, "name.pdf")
#png("name") or Plots.pdf(plot, "name")
#use the macro @. to wrap every proceeding function with .
# common attributes: lc, lw, mc, ms, ma

#=
    x = range(0, 10, length=100)
    y1 = sin.(x).^2
    y2 = cot.(x) .- 1/4
    #display(plot(x, [y1 y2]))
    #p = plot(x, [y1, y2], label=["tan(x)" "cot(x)"], linewidth=2)
    y3 = @. tan(x) - 1/4 # equivalent to y3 = tan.(x) .- 1/4
    #display(plot(x, y3))

    #alt 
    #display(plot!(p, x, y3, title="My nigga", label="tan(x) - 1/4", linewidth=3, xlabel="Nᵢ", ylabel="GGₐ"))


    plot(x, [y1 y2], label=["sin(x)²" "cot(x)"], lw=[2, 1])
    plot!(x, y3, label="tan(x) - 1/4", lw=3, ls=:dot)
    plot!(legend=:outerbottom, legendcolumns=3)
    xlims!(0, 2π)
    title!("Nigga Chins")
    xlabel!("Nigga")
    ylabel!("Chins")
    =#
    #=
    x = range(0, 10, length=100)
    y = @. tan(x)^2 / log10(x)

    plot(x, y, label=L"tan(x)^2 / log10(x)")
    plot!(xscale=:log10, yscale=:log10, minorgrid=true)
    xlims!(1e+0, 1e+2)
    ylims!(1e-4, 1e+4)
    title!(L"Log-log plot of $tan(x)^2 / log10(x)")
    xlabel!(L"x")
    ylabel!(L"y")
    =#

    #=
    x = range(0, 10, length=100)
    y = sin.(x)
    y_noisy = @. sin(x) + 0.1*randn()

    plot(x, y, label="sin(x)")
    plot!(x, y_noisy, seriestype=:scatter, label="data")

=#






# DO NOT REMOVE, gui() is for displaying, and readline is for debugging/not instant exit of display
gui()
readline()