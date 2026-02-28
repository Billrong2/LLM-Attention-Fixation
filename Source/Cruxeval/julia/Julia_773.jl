function f(nums::Vector{Int64}, n::Int64)::Int64 
    return popat!(nums, n+1)
end
using Test

@testset begin

candidate = f;
	@test(candidate([-7, 3, 1, -1, -1, 0, 4], 6) == 4)
end
