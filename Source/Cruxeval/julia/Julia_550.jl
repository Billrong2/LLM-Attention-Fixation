function f(nums::Vector{Int64})::Vector{Int64} 
    for i in 1:length(nums)
        insert!(nums, i, nums[i]^2)
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 4]) == [1, 1, 1, 1, 2, 4])
end
