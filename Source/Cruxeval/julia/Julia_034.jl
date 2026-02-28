function f(nums::Vector{Int64}, odd1::Int64, odd2::Int64)::Vector{Int64} 
    while odd1 in nums
        filter!(x -> x != odd1, nums)
    end
    
    while odd2 in nums
        filter!(x -> x != odd2, nums)
    end
    
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3, 7, 7, 6, 8, 4, 1, 2, 3, 5, 1, 3, 21, 1, 3], 3, 1) == [2, 7, 7, 6, 8, 4, 2, 5, 21])
end
