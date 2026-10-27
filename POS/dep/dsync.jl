"""
    Written by: yuto
    Created At: 2026年(令和8)10月25日
    Description: Desynchronization checker for GAIA. Given the client state and server state at a transaction step.
"""

module desMod

# Using
using Printf

# Includes
include("fh.jl")
include("kalmf.jl")

# Functions
export sdi
using .fhMod
using .kfMod


#==========#

# Defining a custom operator func for ⟹:
→(p::Bool, q::Bool) = !p || q
⟹(p::Bool, q::Bool) = !p || q

#TODO: Do this later. Once finished, PUSH dev -> main or main <- dev
#      @ fh.jl, add new getClientState and getServerState. Add two new cols [7 & 8] on CSV (ClientDone & ServerDone)

cState::Vector{Bool} = zeros(1) # client state at time t, outputs 1 or 0
sState::Vector{Bool} = zeros(1) # server state at time t, outputs 1 or 0

deleteat!(cState, 1)
deleteat!(sState, 1)

#push!(cState, getClientState(df))
#push!(sState, getServerState(df))

"""
    sdi(Boolean, Boolean)
    ...
    The desynchronization checker, it checks whether Sᵢ and Sₛ are not in-sync. It outputs
    the value "1" when the two are mismatched. Otherwise, "0".

    Condition: Let Sᵢ(t) and Sₛ(t) be Client State at time t and Server State at time t.
               Let the State Divergence Indicator (SDI) function, D(t), be the function 
               that acts on Sᵢ and Sₛ at time t. Then, D(t) = 1[Sᵢ(t) ≠ Sₛ(t)].

    Logic:
               (p ⟹ ~p) && q:

               p | q | p ⟹ ~p | (p ⟹ ~p) && q
               1 | 1 |    0    |       0
               1 | 0 |    0    |       0
               0 | 1 |    1    |       1
               0 | 0 |    1    |       0

    Interpretation: With this logic, sdi(1, 0) = 0 could be interpreted as "the transaction was
                    not yet completed, and the server is still processing the transaction."

                    Another one is, sdi(0, 1) = 1 could be interpreted as "the client haven't
                    even started the transaction and the server already logged the data."

    Example:
    @Transaction 45, the system recorded finished client-side (1) and unfinished server-side (0). 
    Then, sdi(Sᵢ(45), Sₛ(45)) = 0.
    ...
"""
function sdi(ClientState::Bool, ServerState::Bool)
    NotClientState = !ClientState

    if (ClientState ⟹ NotClientState) && ServerState    # (p ⟹ ~p) && q
        return 1
    else 
        return 0
    end
end

end