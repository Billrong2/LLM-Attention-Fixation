function f(li::Vector{String})::Vector{Int64} 
    return [count(x -> x == i, li) for i in li]
end
using Test

@testset begin

candidate = f;
	@test(candidate(["k", "x", "c", "x", "x", "b", "l", "f", "r", "n", "g"]) == [1, 3, 1, 3, 3, 1, 1, 1, 1, 1, 1])
end
