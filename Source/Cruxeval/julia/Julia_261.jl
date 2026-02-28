function f(nums::Vector{Int64}, target::Int64)::Tuple{Vector{Int64}, Vector{Int64}} 
    lows = Int64[]
    higgs = Int64[]
    for i in nums
        if i < target
            push!(lows, i)
        else
            push!(higgs, i)
        end
    end
    empty!(lows)
    return lows, higgs
end
using Test

@testset begin

candidate = f;
	@test(candidate([12, 516, 5, 2, 3, 214, 51], 5) == ([], [12, 516, 5, 214, 51]))
end
