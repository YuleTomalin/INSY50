"""
    Written by:satoshi
    Created At:2026年(令和8)10月12日
"""

include("../main.jl")
include("kalmf.jl")

#display(plot(...))
#savefig("name.png") or savefig(plot, "name.pdf")
#png("name") or Plots.pdf(plot, "name")
#use the macro @. to wrap every proceeding function with .
# common attributes: lc, lw, mc, ms, ma

#TODO:  fix where peaks are marked (both positive and negative peaks)
#       replace with customisable options [1-Wk Trans, 2-Wk Trans, 1-Month, 3-Months] (Connect to Dashboard l8r)
#       output to pdf once site is running (output -> res/)

"""
    plotStdInnov(AbstractDataFrame, Float64, String, Bool, String)
    ...
    Plot the Standardized Innovation (rₜ) against a standard normal based on 
    the transaction steps and rₜ. Input also a x label of the innovation (See Plots.jl). 
    If user wants to print to PDF (true) or just show to screen (false), also pass the 
    directory where the PDF should go.
    ...
"""
function plotStdInnov(steps::Vector{Int64}, standardized_innovation::Vector{Float64},  xlbl_main::String, toPdf::Bool, dirPdf::String)
    gr()

    #max_innov, max_idx_innov = findmaxima(std_innov)
    #min_innov, min_idx_innov = findmin(std_innov)

    # Left plot
    p_seq = plot(steps[2:end], standardized_innovation[2:end], label="Std Innov", xlabel=xlbl_main, ylabel="Value", lc=:red, alpha=0.8, lw=:0.7, ylims=(-30, 50))
    #scatter!([max_innov], [max_idx_innov], label="SI Peak per Transaction", mc=:black, ma=1, ms=3)
    #scatter!([min_innov], [min_idx_innov], label="SI Min / Transaction", mc=:green, ma=1, ms=3)
    hline!([2.97, -2.97], color=:black, ls=:dash, label="±2.97")

    # Right plot
    p_dens = density(standardized_innovation, label="Actual Distribution", xlabel="Value", ylabel="Density", lc=:red, fill=(0, 0.2, :red), xlims=(-15, 15))

    # Normal Dist Overlay
    standard_normal(x) = exp(-x^2 / 2) / sqrt(2π)
    plot!(p_dens, standard_normal, -5, 5, label="Theoretical N(0, 1)", color=:black, lw=1.5, ls=:dash)

    custom_layout = grid(1, 2, widths=[0.75, 0.25])

    # Combining then side-by-side
    fpl = plot(p_seq, p_dens, layout=custom_layout, size=(2560, 1440), title=["Innovation Sequence" "Distribution Profile"], bottom_margin = 10mm, left_margin = 10mm)

    if toPdf == true
        Plots.pdf(fpl, dirPdf)
        println("PDF Export complete. Exported to: ", dirPdf)
    else 
        gui()
        readline()
    end
end

plotStdInnov(getSteps(df), std_innov, "Transaction Steps (Jun, 2026 - Oct, 2026), 30 to 70 transactions @ specific dates", true, __DirPDF)