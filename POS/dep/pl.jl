"""
    Written by: yuto
    Created At: 2026年(令和8)10月12日
    Description: This file is the main plotting file for GAIA. It outputs the required plots
                 for evaluation of the system at specific steps of transactions and time.
"""

#TODO: Add customisable options [1-Wk Trans, 2-Wk Trans, 1-Month, 3-Months] (Connect to Dashboard l8r)

module plMod
# Using
using Plots, Measures, LaTeXStrings, Peaks, DataFrames

# Includes
include("fh.jl")
include("kalmf.jl")
include("dsync.jl")

# Functions
using .fhMod
using .kfMod
using .desMod
export plotStdInnov

#==========#


# 1D Vectors for Cstate and Sstate
cst = getClientState(df)
sst = getServerState(df)

onezeroarr = sdi(cst, sst) # => Array of 1s and 0s


"""
    plotStdInnov(Int32[], Float64[], Int64[], String, Bool, String)
    ...
    Plot the Standardized Innovation (rₜ) based on the transaction steps and rₜ. 
    Input also an x label of the innovation (See Plots.jl). If user wants to 
    print to PDF (true) or just show to screen (false), also pass the 
    directory where the PDF should go. Outputs a PDF of a graph or a graph itself.
    ...
"""
@time function plotStdInnov(steps::Vector{Int32}, standardized_innovation::Vector{Float64}, 
                      onezeroarr::Vector{Int64}, xlbl_main::String, toPdf::Bool, dirPdf::String)
    gr() # start plot

    max_innov, max_idx_innov = findmaxima(standardized_innovation)
    min_innov, min_idx_innov = findminima(standardized_innovation)

    # Left plot
    p_seq = plot(steps[2:end], standardized_innovation[2:end], label="Std Innov", xlabel=xlbl_main, ylabel="Value", lc=:red, alpha=0.8, lw=:0.7, ylims=(-35, 50))
    scatter!([max_innov], [max_idx_innov], label="SI ±Peaks per Transaction", mc=:black, ma=1, ms=3)
    scatter!([min_innov], [min_idx_innov], legend_marker_shapesize=2,label="SI Min / Transaction", mc=:green,ma=1, ms=1)
    hline!([3.97, -3.97], color=:black, ls=:dash, label="±3.97")

    # Combining them on top of one another
    p_desync = plot(steps, onezeroarr, seriestype=:steppost, label="SDI", xlabel="Transactions", ylabel="State Divergence", yticks=([0, 1], ["Synchronized", "Divergent"]), ylims=(-0.1, 1.1), lc=:blue, lw=1.5)

    fpl = plot(p_seq, p_desync, layout=(2, 1), link=:x, size=(2560, 1440), left_margin=10mm, bottom_margin=10mm, plot_title="Latency Anomaly and State Divergence Analysis")

    if toPdf == true
        Plots.pdf(fpl, dirPdf)
        println("PDF Export complete. Exported to: ", dirPdf)
    else 
        gui()
        readline()
    end
end

plotStdInnov(getSteps(df), std_innov, onezeroarr, "Transaction Steps", true, __SDirPDF)

#=
"""
    cif(Int32[], Float64[], Int64[], Bool, String)
    ...
    The Cooccurence Indicator Function. It will tell whether the given dataset
    was either general latency, general desynchronization, or having both, which
    is latency-induced desynchronization. This is the final number needed to identify
    whether the system really was experiencing problems during operating times, or
    just a minor inconvenience durig peak-hours where transaction rates are 
    continuous. Outputs a PDF of a graph or a graph itself.
    ...
"""
@time function cif(steps::Vector{Int32}, SI::Vector{Float64}, SDI::Vector{Int64}, toPdf::Bool, dirPdf::String)
    
    
    for s ∈ SI
        for sd ∈ SDI
            if s .> 3.97 .&& sd .== 1
                # Latency-induced Desync
            elseif s .< -3.97 .&& sd .== 1
                # Latency-induced Desync
            elseif s .> 3.97 .&& sd .== 0
                # General Latency
            elseif s .< -3.97 .&& sd .== 0
                # General Latency
            elseif (s .<= 3.97 .&& s .>= -3.97) .&& sd .== 1
                # General Desync (Anomalous)
            elseif (s .<= 3.97 .&& s .>= -3.97) .&& sd .== 0
                # Normal, no latency or desync happened, return some value
            else
                error("Error: invalid input of data...")
            end
        end
    end

    gr()

    # PLOT CODE HERE

    if toPdf == true
        Plots.pdf(fpl, dirPdf)
        println("PDF Export complete. Exported to: ", dirPdf)
    else 
        gui()
        readline()
    end
    # TODO: Complete This function and plot data against steps
end
=#
end # module