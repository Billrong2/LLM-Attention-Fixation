function f(nums::Vector{Int64})::Vector{Int64} 
    count = length(nums)
    for num in 2:count
        sort!(nums)
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([-6, -5, -7, -8, 2]) == [-8, -7, -6, -5, 2])
end
