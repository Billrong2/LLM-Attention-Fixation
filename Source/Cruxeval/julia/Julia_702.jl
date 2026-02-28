function f(nums::Vector{Int64})::Vector{Int64} 
    count = length(nums)
    for i in reverse(1:length(nums))
        insert!(nums, i, popfirst!(nums))
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, -5, -4]) == [-4, -5, 0])
end
