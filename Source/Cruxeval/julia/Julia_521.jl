function f(nums::Vector{Int64})::Vector{Int64} 
    m = maximum(nums)
    for i in 1:m
        reverse!(nums)
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([43, 0, 4, 77, 5, 2, 0, 9, 77]) == [77, 9, 0, 2, 5, 77, 4, 0, 43])
end
