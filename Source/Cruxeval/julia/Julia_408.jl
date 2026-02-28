function f(m::Vector{Int64})::Vector{Int64} 
    reverse!(m)
    return m
end
using Test

@testset begin

candidate = f;
	@test(candidate([-4, 6, 0, 4, -7, 2, -1]) == [-1, 2, -7, 4, 0, 6, -4])
end
