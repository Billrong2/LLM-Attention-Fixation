function f(nums::Vector{Int64})::Vector{Int64} 
    count = length(nums)
    for i in 1:count
        insert!(nums, i, nums[i]*2)
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 8, -2, 9, 3, 3]) == [4, 4, 4, 4, 4, 4, 2, 8, -2, 9, 3, 3])
end
