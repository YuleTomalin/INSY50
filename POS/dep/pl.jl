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

gr()
## TODO: INPUT FROM KF

t = rand(1, 10) # x
y = rand(10)
xₜ = [2.343, 3.143, 2.184, 1.542, 1.665] # y

scatter(t, y, title="KF", xlabel="t", ylabel="xₜ")

# DO NOT REMOVE, gui() is for displaying, and readline is for debugging/not instant exit of display
gui()
readline()