function f(nums::Vector{Int}, spot::Int, idx::Int)::Vector{Int}
    insert!(nums, spot+1, idx)
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 0, 1, 1], 0, 9) == [9, 1, 0, 1, 1])
end
