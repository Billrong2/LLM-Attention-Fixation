function f(nums::Vector{Int64})::String 
    empty!(nums)
    return "quack"
end
using Test

@testset begin

candidate = f;
	@test(candidate([2, 5, 1, 7, 9, 3]) == "quack")
end
