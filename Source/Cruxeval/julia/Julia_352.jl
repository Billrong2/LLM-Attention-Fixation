function f(nums::Vector{Int64})::Int64 
    return nums[div(length(nums), 2) + 1]
end
using Test

@testset begin

candidate = f;
	@test(candidate([-1, -3, -5, -7, 0]) == -5)
end
