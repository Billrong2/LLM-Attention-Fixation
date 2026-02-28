function f(nums::Vector{Int64})::Vector{Int64} 
    for i in 1:length(nums)
        if i % 2 != 0
            push!(nums, nums[i] * nums[i+1])
        end
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([])) == Vector{Int64}([]))
end
