function f(nums::Vector{Int64}, rmvalue::Int64)::Vector{Int64} 
    res = copy(nums)
    while rmvalue in res
        index = findfirst(x -> x == rmvalue, res)
        popped = splice!(res, index)
        if popped != rmvalue
            push!(res, popped)
        end
    end
    return res
end
using Test

@testset begin

candidate = f;
	@test(candidate([6, 2, 1, 1, 4, 1], 5) == [6, 2, 1, 1, 4, 1])
end
