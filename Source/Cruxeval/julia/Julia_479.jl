function f(nums::Vector{Int64}, pop1::Int64, pop2::Int64)::Vector{Int64} 
    splice!(nums, pop1)
    splice!(nums, pop2)
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 5, 2, 3, 6], 2, 4) == [1, 2, 3])
end
