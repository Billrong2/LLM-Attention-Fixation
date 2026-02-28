function f(nums::Vector{Int64}, target::Int64)::Int64 
    if count(x -> x == 0, nums) > 0
        return 0
    elseif count(x -> x == target, nums) < 3
        return 1
    else
        return findfirst(x -> x == target, nums)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 1, 1, 2], 3) == 1)
end
