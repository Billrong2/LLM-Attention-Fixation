function f(nums::Vector{Int64})::Vector{Int64} 
    count = length(nums)
    while length(nums) > div(count, 2)
        empty!(nums)
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 1, 2, 3, 1, 6, 3, 8]) == Vector{Int64}([]))
end
