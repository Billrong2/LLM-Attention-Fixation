function f(nums::Vector{Int64})::Vector{Int64} 
    a = 1
    for i in 1:length(nums)
        insert!(nums, i, nums[a])
        a += 1
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 3, -1, 1, -2, 6]) == [1, 1, 1, 1, 1, 1, 1, 3, -1, 1, -2, 6])
end
