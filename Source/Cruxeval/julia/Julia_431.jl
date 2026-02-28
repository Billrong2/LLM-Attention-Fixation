function f(n::Int64, m::Int64)::Vector{Int64} 
    arr = collect(1:n)
    for i in 1:m
        empty!(arr)
    end
    return arr
end
using Test

@testset begin

candidate = f;
	@test(candidate(1, 3) == Vector{Int64}([]))
end
