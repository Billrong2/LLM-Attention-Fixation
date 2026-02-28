function f(nums::Vector{Int64}, target::Int64)::Int64 
    cnt = count(x -> x == target, nums)
    return cnt * 2
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 1], 1) == 4)
end
