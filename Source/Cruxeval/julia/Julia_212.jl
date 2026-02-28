function f(nums::Vector{Int64})::Vector{Int64} 
    for _ in 1:length(nums) - 1
        reverse!(nums)
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, -9, 7, 2, 6, -3, 3]) == [1, -9, 7, 2, 6, -3, 3])
end
