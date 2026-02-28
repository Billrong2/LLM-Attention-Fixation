function f(num1::Int64, num2::Int64, num3::Int64)::String 
    nums = [num1, num2, num3]
    sort!(nums)
    return string(nums[1], ",", nums[2], ",", nums[3])
end
using Test

@testset begin

candidate = f;
	@test(candidate(6, 8, 8) == "6,8,8")
end
