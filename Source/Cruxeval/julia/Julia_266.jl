function f(nums::Vector{Int64})::Vector{Int64} 
    for i in length(nums):-1:1
        if nums[i] % 2 == 1
            insert!(nums, i+1, nums[i])
        end
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 3, 4, 6, -2]) == [2, 3, 3, 4, 6, -2])
end
