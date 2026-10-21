"""
    Written by:satoshi
    Created At:2026年(令和8)10月21日
"""

#using Pkg; Pkg.add("Genie")

using Genie

route("/hello") do 
    "Hello, Julia!!!"
end

up(8001, async=false)