"""
    Written by:satoshi
    Created At:2026年(令和8)10月12日
"""

#import Pkg; Pkg.add("KalmanFilters")
using Dates
using KalmanFilters
using Printf
using InteractiveUtils
include("fh.jl")


## TODO: ONCE I/O IS WORKING, CONVERT EVERYTHING TO REUSABLE FUNCTIONS

## MAIN STRUCTS

struct TransactionRecord
    id::Int         #Transaction id
    Tᵢ::Float32     #Client init time
    Tₛ::Float32     #Server processing/completion time
    z::Float32      #Measurement
    tₘ::DateTime    #Measurement time
end

struct TransactionAnalysis
    transaction::TransactionRecord
    xₜ₋₁::Float32   #Predicted latency
    pₜ₋₁::Float32   #Predicted latency variance
    νₜ::Float32     #Innovation
    Sₜ::Float32     #Innov. variance
    K::Float32      #Kalman gain
    xₜ::Float32     #Estimated latency
    rₜ::Float32     #Stdized innov.
end

## Needs to have input from somewhere, I/O from fh.jl
#transactionObj = TransactionRecord()
#analObj = TransactionAnalysis()

## TIME





# connect to I/O
measurements::Vector{Float64} = zeros(1)
deleteat!(measurements, 1)

for i in eachindex(clTime)
    push!(measurements, (svTime[i] - clTime[i]))
end



## MAIN DEFINITIONS (ARBITRARY DATA, NEEDS TO BE A SCALAR AND NOT A VECTOR)
F = 1.0         # state-transaction matrix (1x1); F = [1] since no changes in state
H = 1.0         # measurement matrix (1x1) ; H = [1] since there is a direct measurement of the state
Q = 0.1         # var(q)
R = 0.46        # var(w) or var(measurements)
x_init = 1.0   # init est
p_init = 1.0    # init cov(xₜ₋₁)


let mu = measurement_update(
    x_init,
    p_init,
    measurements[1],
    H,
    R
)

# DO NOT UNCOMMENT, DEBUGGING PURPOSES ONLY
#println(@which measurement_update(x_init,p_init,measurements[1],H,R))

estimates = Float64[]
push!(estimates, get_state(mu)[1])

for z ∈ measurements[2:end]

    prediction = time_update(
        get_state(mu),
        get_covariance(mu),
        F,
        Q
    )

    mu = measurement_update(
        get_state(prediction),
        get_covariance(prediction),
        z,
        H,
        R
    )

    push!(estimates, get_state(mu)[1])
end
 
# print
for e ∈ estimates
    @printf("Estimate %.3f\n", e) # adjust %.# for significant digits
end

end ## let ... end 