function f(nums::Vector{Int64})::Vector{Tuple{Int64, Int64}} 
    output = []
    for n in nums
        push!(output, (count(x->x==n, nums), n))
    end
    sort!(output, rev=true)
    return output
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 1, 3, 1, 3, 1]) == [(4, 1), (4, 1), (4, 1), (4, 1), (2, 3), (2, 3)])
end
