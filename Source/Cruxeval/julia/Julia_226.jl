function f(nums::Vector{Int64})::Vector{Int64} 
    n = length(nums)
    for i in 1:n
        if nums[i] % 3 == 0
            push!(nums, nums[i])
        end
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 3]) == [1, 3, 3])
end
