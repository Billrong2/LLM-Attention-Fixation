function f(array::Vector{Int64}, elem::Int64)::Int64 
    if elem in array
        return findfirst(x -> x == elem, array) - 1
    else
        return -1
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate([6, 2, 7, 1], 6) == 0)
end
