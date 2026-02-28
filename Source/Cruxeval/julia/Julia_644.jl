function f(nums::Vector{Int64}, pos::Int64)::Vector{Int64} 
    s = 1:length(nums)
    if pos % 2 != 0
        s = 1:length(nums) - 1
    end
    reverse!(view(nums, s))
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([6, 1], 3) == [6, 1])
end
