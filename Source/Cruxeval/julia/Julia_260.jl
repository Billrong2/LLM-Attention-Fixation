function f(nums::Vector{Int64}, start::Int64, k::Int64)::Vector{Int64}
    if start + k <= length(nums)
        nums[start+1:start+k] = nums[start+1:start+k][end:-1:1]
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3, 4, 5, 6], 4, 2) == [1, 2, 3, 4, 6, 5])
end
