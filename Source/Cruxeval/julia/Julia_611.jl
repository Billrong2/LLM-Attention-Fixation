function f(nums::Vector{Int64})::Vector{Int64} 
    reverse!(nums)
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([-6, -2, 1, -3, 0, 1]) == [1, 0, -3, 1, -2, -6])
end
