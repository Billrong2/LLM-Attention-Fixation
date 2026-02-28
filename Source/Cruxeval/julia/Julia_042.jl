function f(nums::Vector{Int64})::Vector{Int64} 
    nums = []
    for num in nums
        push!(nums, num * 2)
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([4, 3, 2, 1, 2, -1, 4, 2]) == Vector{Int64}([]))
end
