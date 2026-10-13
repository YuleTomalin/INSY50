#import Pkg; Pkg.add("KalmanFilters")
using Dates
using KalmanFilters

using InteractiveUtils

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

#transactionObj = TransactionRecord()
#analObj = TransactionAnalysis()

measurements = [2.87, 4.67, 2.89, 3.02, 2.59, 3.12]


## MAIN DEFINITIONS (ARBITRARY DATA)
F = 1.0 # state-transaction matrix (1x1); F = [1] since no changes in state
H = 1.0 # measurement matrix (1x1) ; H = [1] since there is a direct measurement of the state
Q = 0.1 # var(q)
R = 0.46 # var(w) or var(measurements)
x_init = 3.45 # init est
p_init = 1.0 # init cov(xₜ₋₁)


let mu = measurement_update(
    x_init,
    p_init,
    measurements[1],
    H,
    R
)

#println(@which measurement_update(x_init,p_init,measurements[1],H,R))

estimates = Float64[]
push!(estimates, get_state(mu)[1])

for z in measurements[2:end]

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

println(estimates) 

end ## let ... end 