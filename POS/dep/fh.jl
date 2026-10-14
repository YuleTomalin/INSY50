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

using CSV, DataFrames, Dates, Parsers


## TODO: Complete FILE HANDLING w/ automated folder finding and csv or zip

fd = "/Users/sunlifehd/Documents/INSY50/POS/res/sample.csv"

df = CSV.read(fd, DataFrame)

raw_cₛ = Dates.value.(Second.(df[:, 4]))
raw_cₘₛ = Dates.value.(Millisecond.(df[:, 4]))
clTime::Vector{Float64} = raw_cₛ .+ (raw_cₘₛ ./ 1000) # get Client Initiation Time

raw_sₛ = Dates.value.(Second.(df[:, 5]))
raw_sₘₛ = Dates.value.(Millisecond.(df[:, 5]))
svTime::Vector{Float64} = raw_sₛ .+ (raw_sₘₛ ./ 1000) # get Server Processing Time
