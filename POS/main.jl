"""
    Written by:satoshi
    Created At: 2026年(令和8)10月9日
    Description: This is the main file for everything related to the POS, GAIA.
"""

# MAIN FILE
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
import Pkg; Pkg.add("Genie")
import Pkg; Pkg.add("GenieFramework")
import Pkg; Pkg.add("Measures")
=#

#__RelDIR = joinpath(@__DIR__, "main.jl")

module mainModule
export __DirPDF

__DirPDF = joinpath(@__DIR__, "res/dataplot.pdf")
end