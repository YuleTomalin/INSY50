"""
    Written by:satoshi
    Created At:2026年(令和8)10月12日
"""

#import Pkg; Pkg.add("KalmanFilters")
#import Pkg; Pkg.add("StatsPlots")
using Dates
using KalmanFilters
using Printf
using StatsPlots
using InteractiveUtils

include("fh.jl")



# connected to I/O
measurements::Vector{Float64} = zeros(1) # zₜ
deleteat!(measurements, 1)
estimates = Float64[] # xₜ
std_innov = Float64[2001]
#threshold = 3.0
#anomalies = abs.(std_innov) .> threshold

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

    prediction = time_update( # Step 1 and 2 (xₜ₋₁ and pₜ₋₁)
        get_state(mu),
        get_covariance(mu),
        F,
        Q
    )

    xₜ₋₁ = get_state(prediction)
    pₜ₋₁ = get_covariance(prediction)

    ν = z - (H * xₜ₋₁)[1] # innovation

    S = (H * pₜ₋₁ * H')[1, 1] + R[1, 1] # innovation variance

    r = ν / sqrt(S) # standardized innovation

    push!(std_innov, r) # y2

    mu = measurement_update( # Steps 3 to 7 (νₜ -> Sₜ -> Kₜ -> x̂ₜ -> Pₜ)
        get_state(prediction),
        get_covariance(prediction),
        z,
        H,
        R
    )

    push!(estimates, get_state(mu)[1]) # y1
end
end ## let ... end 