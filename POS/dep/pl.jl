"""
    Written by:satoshi
    Created At:2026年(令和8)10月12日
"""

#import Pkg; Pkg.add("Plots")
#import Pkg; Pkg.add("LaTeXStrings")
import Pkg; Pkg.add("Peaks")
using Plots
using LaTeXStrings
using Peaks

include("kalmf.jl")

#display(plot(...))
#savefig("name.png") or savefig(plot, "name.pdf")
#png("name") or Plots.pdf(plot, "name")
#use the macro @. to wrap every proceeding function with .
# common attributes: lc, lw, mc, ms, ma

#TODO: replace with customisable options [1-Wk Trans, 2-Wk Trans, 1-Month, 3-Months] (Connect to Dashboard l8r)
#       output to pdf once site is running (output -> res/)

gr()

# Left plot
#max_innov, max_idx_innov = findpeaks(std_innov)

p_seq = plot(getSteps(df)[2:end], std_innov[2:end], label="Std Innov", xlabel="Transaction Steps (Jun, 2026 - Oct, 2026), 30 to 70 transactions @ specific dates", ylabel="Value", lc=:red, alpha=0.8, lw=:0.7, ylims=(-15, 15))
#scatter!([max_innov], [max_idx_innov], label="SI Max", mc=:black, ma=1, ms=3)
hline!([3, -3], color=:black, ls=:dash, label="±3")

# Right plot
p_dens = density(std_innov, label="Actual Distrobution", xlabel="Value", ylabel="Density", lc=:red, fill=(0, 0.2, :red), xlims=(-10, 10))

# Normal Dist Overlay
standard_normal(x) = exp(-x^2 / 2) / sqrt(2π)
plot!(p_dens, standard_normal, -4, 4, label="Theoretical N(0, 1)", color=:black, lw=1.5, ls=:dash)

custom_layout = grid(1, 2, widths=[0.75, 0.25])

# Combining then side-by-side
fpl = plot(p_seq, p_dens, layout=custom_layout,size=(2560, 1440), title=["Innovation Sequence" "Distribution Profile"])

Plots.pdf(fpl, "dataplot.pdf")

#gui()
#readline()