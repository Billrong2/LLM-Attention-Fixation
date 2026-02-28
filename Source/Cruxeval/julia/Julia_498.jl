function f(nums::Vector{Int64}, idx::Int64, added::Int64)::Vector{Int64} 
    insert!(nums, idx + 1, added)
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 2, 2, 3, 3], 2, 3) == [2, 2, 3, 2, 3, 3])
end
