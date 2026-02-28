function f(s::String, from_c::String, to_c::String)::String 
    table = Dict(zip(from_c, to_c))
    return join([get(table, c, c) for c in s])
end
using Test

@testset begin

candidate = f;
	@test(candidate("aphid", "i", "?") == "aph?d")
end
