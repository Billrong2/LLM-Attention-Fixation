function f(nums::Vector{Int64})::Vector{Int64} 
    nums = filter(x -> x > 0, nums)
    if length(nums) <= 3
        return nums
    end
    nums = reverse(nums)
    half = div(length(nums), 2)
    return vcat(nums[1:half], zeros(Int64, 5), nums[half+1:end])
end
using Test

@testset begin

candidate = f;
	@test(candidate([10, 3, 2, 2, 6, 0]) == [6, 2, 0, 0, 0, 0, 0, 2, 3, 10])
end
