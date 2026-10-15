"""
    Written by:satoshi
    Created At:2026年(令和8)10月12日
"""

## FILE HANDLING

## IMPORTS
#import Pkg; Pkg.add("CSV")
#import Pkg; Pkg.add("DataFrames")
#import Pkg; Pkg.add("Dates")
#import Pkg; Pkg.add("Parsers")
#import Pkg; Pkg.add("Plots")

using CSV, DataFrames, Dates, Parsers, Plots


## TODO: Complete FILE HANDLING w/ automated folder finding and csv or zip

fd = "/Users/sunlifehd/Documents/INSY50/POS/res/SAMPLE_250.csv"

"""
    getClientTime(AbstractDataFrame)
    ...
    Get the client initiation time (Tᵢ) using a DataFrame
    object (see getCSV(String, AbstractDataFrame)) as the 
    main input. Tᵢ = tₛ + (tₘₛ / 1000).
    ...
"""
function getClientTime(df::DataFrame)
    raw_cₛ = Dates.value.(Second.(df[:, 3]))
    raw_cₘₛ = Dates.value.(Millisecond.(df[:, 3]))
    clTime::Vector{Float64} = raw_cₛ .+ (raw_cₘₛ ./ 1000)
    return clTime
end

"""
    getServerTime(AbstractDataFrame)
    ...
    Get the server processing time (Tₛ) using a DataFrame
    object (see getCSV(String, AbstractDataFrame)) as the 
    main input. Tₛ = tₛ + (tₘₛ / 1000).
    ...
"""
function getServerTime(df::DataFrame)
    raw_sₛ = Dates.value.(Second.(df[:, 4]))
    raw_sₘₛ = Dates.value.(Millisecond.(df[:, 4]))
    svTime::Vector{Float64} = raw_sₛ .+ (raw_sₘₛ ./ 1000)
    return svTime
end

"""
    getCSV(String, sink[Tables.jl])
    ...
    Get the CSV file from a predetermined directory. 
    "sink" is a Tables.jl object, in this case DataFrame.
    Returns a DataFrame-type object.
    ...
"""
function getCSV(d::String, sink::Core.Any)
    df = CSV.read(d, sink)
    return df
end

df = getCSV(fd, DataFrame)
#println(getServerTime(df), "--------------------\n")
#println(getClientTime(df))

gr()

# this plots using GR
#=
x = range(0, 10, length=100)
y = sin.(x)
y_noisy = @. sin(x) + 0.1*randn()


plot(x, y, label="sin(x)", lc=:black, lw=2)
scatter!(x, y_noisy, label="data", mc=:red, ms=2, ma=0.5)
plot!(legend=:bottomleft)
title!("Sine with noise, plotted with GR")
xlabel!("x")
ylabel!("y")
=#

gui()
readline()