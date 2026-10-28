"""
    Written by:satoshi
    Created At: 2026年(令和8)10月9日
    Description: This is the main file for everything related to GAIA. In-code information could be found here.

    1) General syntax for CSV:
        ID,TransTotAmt,ClientTransTime,ServerTransTime,Date,Step,ClientDone,ServerDone

    2) General idea and definition of terms
"""

# MAIN FILE

# Imported Libraries
#=
import Pkg; Pkg.add("LaTeXStrings")
import Pkg; Pkg.add("Peaks")
import Pkg; Pkg.add("Measures")
import Pkg; Pkg.add("CSV")
import Pkg; Pkg.add("DataFrames")
import Pkg; Pkg.add("Dates")
import Pkg; Pkg.add("Parsers")
import Pkg; Pkg.add("KalmanFilters")
import Pkg; Pkg.add("StatsPlots")
import Pkg; Pkg.add("Measures")
=#

#__RelDIR = joinpath(@__DIR__, "main.jl")