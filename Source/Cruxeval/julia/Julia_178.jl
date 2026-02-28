function f(array::Vector{Int64}, n::Int64)::Vector{Int64} 
    return array[n+1:end]
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, 0, 1, 2, 2, 2, 2], 4) == [2, 2, 2])
end
