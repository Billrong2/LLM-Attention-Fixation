function f(nums::Vector{Int64}, index::Int64)::Int64
    return nums[index+1] % 42 + popat!(nums, index+1) * 2
end


using Test

@testset begin

candidate = f;
	@test(candidate([3, 2, 0, 3, 7], 3) == 9)
end
