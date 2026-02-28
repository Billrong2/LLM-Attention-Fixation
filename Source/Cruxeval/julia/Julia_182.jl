function f(dic::Dict{String, Int})::Vector{Tuple{String, Int}} 
    return sort([(k, v) for (k, v) in dic])
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("b" => 1, "a" => 2)) == [("a", 2), ("b", 1)])
end
