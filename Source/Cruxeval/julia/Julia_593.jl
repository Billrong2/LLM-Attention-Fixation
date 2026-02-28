function f(nums::Vector{Int64}, n::Int64)::Vector{Int64} 
    pos = length(nums)
    for i in -length(nums): -1
        insert!(nums, pos, nums[i])
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([]), 14) == Vector{Int64}([]))
end
