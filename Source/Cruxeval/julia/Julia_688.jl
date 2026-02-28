function f(nums::Vector{Int64})::Vector{Int64} 
    l = Int[]
    for i in nums
        if !(i in l)
            push!(l, i)
        end
    end
    return l
end
using Test

@testset begin

candidate = f;
	@test(candidate([3, 1, 9, 0, 2, 0, 8]) == [3, 1, 9, 0, 2, 8])
end
