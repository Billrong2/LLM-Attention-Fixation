function f(array::Vector{Int64}, elem::Int64)::Int64 
    return count(x -> x == elem, array) + elem
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 1, 1], -2) == -2)
end
