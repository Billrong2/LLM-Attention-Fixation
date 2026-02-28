function f(nums::Vector{Int64}, number::Int64)::Int64 
    return count(x -> x == number, nums)
end
using Test

@testset begin

candidate = f;
	@test(candidate([12, 0, 13, 4, 12], 12) == 2)
end
