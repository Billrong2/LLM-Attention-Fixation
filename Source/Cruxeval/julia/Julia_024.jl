function f(nums::Vector{Int64}, i::Int64)::Vector{Int64}
    popat!(nums, i+1)
    return nums
end

using Test

@testset begin

candidate = f;
	@test(candidate([35, 45, 3, 61, 39, 27, 47], 0) == [45, 3, 61, 39, 27, 47])
end
