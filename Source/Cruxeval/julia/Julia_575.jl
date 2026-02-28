function f(nums::Vector{Int64}, val::Int64)::Int64 
    new_list = []
    for i in nums
        append!(new_list, fill(i, val))
    end
    return sum(new_list)
end
using Test

@testset begin

candidate = f;
	@test(candidate([10, 4], 3) == 42)
end
