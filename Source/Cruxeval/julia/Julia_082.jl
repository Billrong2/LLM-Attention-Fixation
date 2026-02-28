function f(a::String, b::String, c::String, d::String)::String 
    return a != "" ? b : c != "" ? d : c
end
using Test

@testset begin

candidate = f;
	@test(candidate("CJU", "BFS", "WBYDZPVES", "Y") == "BFS")
end
