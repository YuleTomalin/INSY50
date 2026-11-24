"""
    Written by: yuto
    Created At: 2026年(令和8)11月25日
    Description: Server transaction file using Oxygen.jl. C# -> Julia, Julia -> C#.
"""

module servMod

# Using
using Oxygen, HTTP

# Functions
# import the pl functions and modify if necessary

#==========#

@post "/{nameofendpoint | change later}" function(req::HTTP.Request)
    data = json(req)
    #=
    Put processing data here
    =#

    return #processing data function with processing data
end

end # mod end