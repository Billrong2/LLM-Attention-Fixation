function f(nums::Vector{Int64})::Vector{Int64} 
    count = 1
    for i in count:2:length(nums)-1
        nums[i] = max(nums[i], nums[count])
        count += 1
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3]) == [1, 2, 3])
end
