function f(nums::Vector{Int64}, sort_count::Int64)::Vector{Int64} 
    sort!(nums)
    return nums[1:sort_count]
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 2, 3, 4, 5], 1) == [1])
end
