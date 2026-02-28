function f(nums::Vector{Int64})::Union{Bool, Vector{Int64}} 
    for i in reverse(1:length(nums), 3)
        if nums[i] == 0
            empty!(nums)
            return false
        end
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, 0, 1, 2, 1]) == false)
end
