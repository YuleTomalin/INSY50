"""
    Written by:satoshi
    Created At:2026年(令和8)10月12日
"""

#import Pkg; Pkg.add("Plots")
#import Pkg; Pkg.add("LaTeXStrings")
using Plots
using LaTeXStrings

include("kalmf.jl")

## TODO: Get estimate vector (example) to plot

#display(plot(...))
#savefig("name.png") or savefig(plot, "name.pdf")
#png("name") or Plots.pdf(plot, "name")
#use the macro @. to wrap every proceeding function with .
# common attributes: lc, lw, mc, ms, ma

#TODO: replace with customisable options (display HMS.s only or include DMY -> Connect to Dashboard l8r)
#      connect the entire filter together
#      time Steps from Tᵢ - Tᵢ₋₁
#      graph zₜ (line), threshold (±), rₜ (scat) against time

gr()

# Left plot
p_seq = plot(getSteps(df)[2:end], std_innov[2:end], label="Std Innov", xlabel="Transaction Steps (Jun, 2026 - Oct, 2026), 30 to 70 transactions @ specific dates", ylabel="Value", lc=:red, alpha=0.8, lw=:0.7, ylims=(-15, 15))
hline!([2.27, -2.27], color=:black, ls=:dash, label="±2.27")

# Right plot
p_dens = density(std_innov, label="Actual Distrobution", xlabel="Value", ylabel="Density", lc=:red, fill=(0, 0.2, :red), xlims=(-10, 10))

# Normal Dist Overlay
standard_normal(x) = exp(-x^2 / 2) / sqrt(2π)
plot!(p_dens, standard_normal, -4, 4, label="Theoretical N(0, 1)", color=:black, lw=1.5, ls=:dash)

custom_layout = grid(1, 2, widths=[0.75, 0.25])

# Combining then side-by-side
plot(p_seq, p_dens, layout=custom_layout,size=(1200, 720), title=["Innovation Sequence" "Distribution Profile"])

gui()
readline()