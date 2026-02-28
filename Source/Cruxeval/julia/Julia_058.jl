function f(nums::Vector{Int64})::Vector{Int64} 
    count = length(nums)
    for i in 0:count-1
        push!(nums, nums[i % 2 + 1])
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([-1, 0, 0, 1, 1]) == [-1, 0, 0, 1, 1, -1, 0, -1, 0, -1])
end
