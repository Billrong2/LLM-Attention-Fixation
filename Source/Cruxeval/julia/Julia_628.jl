function f(nums::Vector{Int64}, delete::Int64)::Vector{Int64} 
    filter!(x -> x != delete, nums)
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([4, 5, 3, 6, 1], 5) == [4, 3, 6, 1])
end
