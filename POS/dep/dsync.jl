"""
    Written by: yuto
    Created At: 2026年(令和8)10月25日
    Description: Desynchronization checker for GAIA. Given the time.
"""

module desMod

# Using


# Includes


# Functions
export sdi
using .fhMod
using .kfMod


#==========#

#TODO: Do this later. Once finished, PUSH dev -> main or main <- dev
#      @ fh.jl, add new getClientState and getServerState. Add two new cols on CSV (ClientDone & ServerDone)
#      Condition: Let Sᵢ(t) and Sₛ(t) be Client State at time t and Server State at time t.
#                 Let the State Divergence Indicator (SDI), D(t), be the function that acts on Sᵢ and Sₛ at time t.
#                 Then, D(t) = 1[Sᵢ(t) ≠ Sₛ(t)].

cState::Vector{Bool} = zeros(1) # client state at time t, outputs 1 or 0
sState::Vector{Bool} = zeros(1) # server state at time t, outputs 1 or 0

deleteat!(cState, 1)
deleteat!(sState, 1)

push!(cState, getClientState(df))
push!(sState, getServerState(df))

"""
"""
function sdi(ClientState::Bool, ServerState::Bool, t::Int64) # change "t" when needed

end

end