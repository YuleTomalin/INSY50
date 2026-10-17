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


## MAIN STRUCTS

# connect to I/O
measurements::Vector{Float64} = zeros(1) # zₜ
deleteat!(measurements, 1)
estimates = Float64[] # xₜ

df = getCSV(dir, DataFrame)
C_df = getClientTime(df)
S_df = getServerTime(df)
for i in 1:size(C_df, 1) # using ClientTime dataframe as guide
    push!(measurements, S_df[i] - C_df[i])
end

# MAIN DEFINITIONS (ARBITRARY DATA, NEEDS TO BE A SCALAR AND NOT A VECTOR)
F = 1.0         # state-transaction matrix (1x1); F = [1] since no changes in state
H = 1.0         # measurement matrix (1x1) ; H = [1] since there is a direct measurement of the state
Q = 0.1         # var(q)
R = 0.5        # var(w) or var(measurements)
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
 
# print/send to pl.jl
for e ∈ estimates
    @printf("Estimate %.3f\n", e) # adjust %.# for significant digits
end

## TODO: Replace @printf to regular output, then connect the entire filter together

end ## let ... end 