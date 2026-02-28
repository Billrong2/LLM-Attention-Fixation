function f(nums::Vector{Int64})::Vector{Int64} 
    a = -1
    b = nums[2:end]
    while a <= b[1]
        splice!(nums, findfirst(x -> x == b[1], nums))
        a = 0
        b = b[2:end]
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([-1, 5, 3, -2, -6, 8, 8]) == [-1, -2, -6, 8, 8])
end
