"""
    Written by:satoshi
    Created At: 2026年(令和8)10月21日
    Description: Test, could be renamed l8r idk
"""

using DataFrames, Genie, Genie.Renderer, Genie.Renderer.Html, Genie.Renderer.Json
# TODO: DO EVERYTHING HERE

route("/hello.html") do 
    html("This is hello.html")
end

route("/hello.json") do 
    json("Hello.json :)")
end

route("/hello.txt") do 
    respond("some text", "text/csv")
end

greet() = "Genie he youkoso!"


route("/greet", greet) # [GET] /greet => greet()
up(8001, async=false)