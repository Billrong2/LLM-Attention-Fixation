function f(line::String, equalityMap::Vector{Tuple{String, String}})::String 
    rs = Dict(equalityMap)
    return mapreduce(c -> get(rs, string(c), string(c)), *, line)
end
using Test

@testset begin

candidate = f;
	@test(candidate("abab", [("a", "b"), ("b", "a")]) == "baba")
end
