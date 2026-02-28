function f(nums::Vector{String})::Vector{String} 
    nums = [lpad(val, parse(Int, nums[1]), '0') for val in nums[2:end]]
    return string.(nums)
end
using Test

@testset begin

candidate = f;
	@test(candidate(["1", "2", "2", "44", "0", "7", "20257"]) == ["2", "2", "44", "0", "7", "20257"])
end
