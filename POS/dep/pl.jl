"""
    Written by: yuto
    Created At: 2026年(令和8)10月12日
    Description: This file is the main plotting file for GAIA. It outputs the required plots
                 for evaluation of the system at specific steps of transactions and time.
"""

#TODO: FInish cif (before thursday)

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

#TODO (Until Nov. 26): Complete functions, and connect Julia code in some way from C# site

"""

    ...
    ...
"""
function setmin(inputVect::Vector)

end

"""

    ...
    ...
"""
function setmax(inputVect::Vector)
end


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
function plotStdInnov(steps::Vector{Int32}, standardized_innovation::Vector{Float64}, 
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


@enum TransCond begin
    NORMAL
    LATENCY_ANOMALY
    STATE_DESYNC
    LATENCY_DESYNC
end

"""
    classifyTransaction(Float, Int)
    ... 
    ...
"""
function classifyTransaction(s::Float64, sd::Int64)
    threshold = 3.97

    if sd != 0 && sd != 1
        error("Invalid SDI value: expected 0 or 1.")
    end

    if abs(s) > threshold && sd == 1
        return LATENCY_DESYNC

    elseif abs(s) > threshold && sd == 0
        return LATENCY_ANOMALY

    elseif abs(s) <= threshold && sd == 1
        return STATE_DESYNC

    else
        return NORMAL
    end
end

"""
    cif(Int32[], Float64[], Int64[], Bool, String)
    ...
    The Cooccurence Indicator Function. It will tell whether the given dataset
    was either general latency, general desynchronization, or having both, which
    is latency-induced desynchronization. This is the final number needed to identify
    whether the system really was experiencing problems during operating times, or
    just a minor inconvenience durig peak-hours where transaction rates are 
    continuous. Outputs a PDF of a graph or a graph itself. SI = Standardized innovation
    SDI = State Divergence Indicator
    ...
"""
function cif(steps::Vector{Int32}, SI::Vector{Float64}, SDI::Vector{Int64}, TransactionCondition, toPdf::Bool, dirPdf::String)
    if !(length(steps) == length(SI) == length(SDI))
        error("Input vectors must have matching lengths.")
    end

    conditions = TransactionCondition[]

    for (s, sd) ∈ zip(SI, SDI)
        push!(conditions, classifyTransaction(s, sd))
    end

    gr()

    p = plot(steps[2:end], SI[2:end], label="SI", lc=:lightblue, alpha=0.85, lw=0.30)
    scatter!(SDI[2:end], label="SDI", mc=:red, ma=1, ms=0.5)
    #scatter!(conditions, label="CONDS", mc=:green, ma=0.8, ms=3)


    if toPdf == true
        Plots.pdf(p, dirPdf)
        println("PDF Export complete. Exported to: ", dirPdf)
    else 
        gui()
        readline()
    end
end

cif(getSteps(df), std_innov, onezeroarr, TransCond, true, __DesDirPDF)


end # module