function f(array::Vector{Int64}, elem::Int64)::Int64
    reverse!(array)
    found = findfirst(x -> x == elem, array)
    reverse!(array)
    return found - 1
end
using Test

@testset begin

candidate = f;
	@test(candidate([5, -3, 3, 2], 2) == 0)
end
