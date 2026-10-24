"""
    Written by:satoshi
    Created At: 2026年(令和8)10月12日
    Description: File handling file for GAIA.
"""

module fhMod

# Using
using CSV, DataFrames, Dates, Parsers

# Functions
export getClientTime, getServerTime, getCSV, dir, std_innov, getSteps

# Includes


#==========#

# TODO: automated folder finding and csv or zip

filename::String = "transactions_2000.csv"
__InpCSVDIR = joinpath(@__DIR__, "..", "res/")
global dir = joinpath(__InpCSVDIR, filename)

"""
    getClientTime(AbstractDataFrame)
    ...
    Get the client initiation time (Tᵢ) using a DataFrame
    object (see getCSV(String, AbstractDataFrame)) as the 
    main input. Tᵢ = tₛ + (tₘₛ / 1000). Outputs in SS.sss
    ...
"""
function getClientTime(df::DataFrame) # in SS.sss
    raw_cₕ = Dates.value.(Hour.(df[:, 3]))
    sec_cₕ = raw_cₕ * 3600
    raw_cₘ = Dates.value.(Minute.(df[:, 3]))
    sec_cₘ = raw_cₘ * 60
    raw_cₛ = Dates.value.(Second.(df[:, 3]))
    raw_cₘₛ = Dates.value.(Millisecond.(df[:, 3]))
    clTime::Vector{Float64} = sec_cₕ + sec_cₘ + raw_cₛ .+ (raw_cₘₛ ./ 1000)
    return clTime
end

"""
    getServerTime(AbstractDataFrame)
    ...
    Get the server processing time (Tₛ) using a DataFrame
    object (see getCSV(String, AbstractDataFrame)) as the 
    main input. Tₛ = tₛ + (tₘₛ / 1000). Outputs in SS.sss
    ...
"""
function getServerTime(df::DataFrame) # in SS.sss
    raw_sₕ = Dates.value.(Hour.(df[:, 4]))
    sec_sₕ = raw_sₕ * 3600
    raw_sₘ = Dates.value.(Minute.(df[:, 4]))
    sec_sₘ = raw_sₘ * 60
    raw_sₛ = Dates.value.(Second.(df[:, 4]))
    raw_sₘₛ = Dates.value.(Millisecond.(df[:, 4]))
    svTime::Vector{Float64} = sec_sₕ + sec_sₘ + raw_sₛ .+ (raw_sₘₛ ./ 1000)
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

"""
    getSteps(AbstractDataFrame)
    ...
    Get the time steps from a transaction CSV record.
    ...
"""
function getSteps(df::DataFrame)
    transstep = df[:, 6]
    return transstep
end

end # module