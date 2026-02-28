function f(a::Vector{String}, b::Vector{Int64})::Vector{Int64} 
    d = Dict(zip(a, b))
    sort(a, by=x->d[x], rev=true)
    return [d[x] for x in a]
end
using Test

@testset begin

candidate = f;
	@test(candidate(["12", "ab"], [2, 2]) == [2, 2])
end
