function f(nums::Vector{Int64}, fill::String)::Dict{Int64, String}
    ans = Dict(i => fill for i in nums)
    return ans
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, 1, 1, 2], "abcca") == Dict(0 => "abcca", 1 => "abcca", 2 => "abcca"))
end
