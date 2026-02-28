function f(nums::Vector{Int64})::Vector{Int64} 
    i = length(nums)
    while i > 0
        if nums[i] % 2 == 0
            splice!(nums, i)
        end
        i -= 1
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([5, 3, 3, 7]) == [5, 3, 3, 7])
end
