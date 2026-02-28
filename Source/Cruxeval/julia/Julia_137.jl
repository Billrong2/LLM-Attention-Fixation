function f(nums::Vector{Int64})::Vector{Int64} 
    count = 0
    while length(nums) > 0
        if count % 2 == 0
            pop!(nums)
        else
            splice!(nums, 1)
        end
        count += 1
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([3, 2, 0, 0, 2, 3]) == Vector{Int64}([]))
end
