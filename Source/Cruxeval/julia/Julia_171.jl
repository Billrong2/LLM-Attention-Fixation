function f(nums::Vector{Int64})::Vector{Int64} 
    count = length(nums) ÷ 2
    for _ in 1:count
        popfirst!(nums)
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([3, 4, 1, 2, 3]) == [1, 2, 3])
end
