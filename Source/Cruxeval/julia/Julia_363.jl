function f(nums::Vector{Int64})::Vector{Int64} 
    sort(nums)
    n = length(nums)
    new_nums = [nums[div(n,2)+1]]
    
    if n % 2 == 0
        new_nums = [nums[div(n,2)], nums[div(n,2)+1]]
    end
    
    for i in 0:(div(n,2)-1)
        pushfirst!(new_nums, nums[n-i])
        push!(new_nums, nums[i+1])
    end
    return new_nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1]) == [1])
end
