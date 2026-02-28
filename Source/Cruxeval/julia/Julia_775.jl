function f(nums::Vector{Int64})::Vector{Int64} 
    count = length(nums)
    for i in 1:count ÷ 2
        nums[i], nums[count-i+1] = nums[count-i+1], nums[i]
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 6, 1, 3, 1]) == [1, 3, 1, 6, 2])
end
