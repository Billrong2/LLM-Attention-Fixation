function f(nums::Vector{Int64})::Vector{Int64} 
    count = length(nums)
    if count == 0
        nums = fill(0, pop!(nums))
    elseif count % 2 == 0
        empty!(nums)
    else
        deleteat!(nums, 1:count ÷ 2)
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([-6, -2, 1, -3, 0, 1]) == Vector{Int64}([]))
end
