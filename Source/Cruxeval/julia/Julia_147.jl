function f(nums::Vector{Int64})::Vector{Int64} 
    middle = div(length(nums), 2)
    return vcat(nums[middle+1:end], nums[1:middle])
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 1, 1]) == [1, 1, 1])
end
