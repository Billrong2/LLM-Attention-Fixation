function f(nums::Vector{Int64}, pos::Int64, value::Int64)::Vector{Int64}
    insert!(nums, pos + 1, value)
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([3, 1, 2], 2, 0) == [3, 1, 0, 2])
end
