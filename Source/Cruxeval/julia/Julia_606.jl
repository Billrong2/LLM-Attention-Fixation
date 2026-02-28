function f(value::String)::String 
    ls = collect(value)
    push!(ls,'N','H','I','B')
    return join(ls,"")
end
using Test

@testset begin

candidate = f;
	@test(candidate("ruam") == "ruamNHIB")
end
