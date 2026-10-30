"""
    Written by:satoshi
    Created At: 2026年(令和8)10月9日
    Description: This is the main file for everything related to GAIA. In-code information could be found here.

    1) General syntax for CSV:
        ID,TransTotAmt,ClientTransTime,ServerTransTime,Date,Step,ClientDone,ServerDone

    2) General idea and definition of terms:
        GAIA uses a 1D Kalman Filter, this means it can only input 1D matrices and vectors of type [] and not [[]] or [][], as a way
        to "clean" and in an essence, average-out, the data from noisy data. 
        
        Noise could be interpreted as ...

        Another available plotting method is by the desynchronization, although it is preferably used with the Kalman'ed plot. 
        Desynchronization in this system, is the degredation of the system during critical times and times where continuous 
        processing of data is required.

        innovation is the ...

        The Standardized innovation is the uncertain innovation ...

    3)
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