function f(nums::Vector{Int64}, p::Int64)::Int64 
    prev_p = p - 1
    if prev_p < 0
        prev_p = length(nums) - 1
    end
    return nums[prev_p + 1]
end
using Test

@testset begin

candidate = f;
	@test(candidate([6, 8, 2, 5, 3, 1, 9, 7], 6) == 1)
end
