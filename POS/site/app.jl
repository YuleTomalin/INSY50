ENV["GENIE_ENV"] = "dev" # Forces local dev configuration
using GenieFramework
@genietools

@app begin
    @in name = "Von!"
end

@page("/", "app.jl.html")
Server.isrunning() || Server.up() # Forces the background server to bind correctly
