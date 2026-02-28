function f(nums::Vector{Int64}, elements::Vector{Int64})::Vector{Int64} 
    result = []
    for i in 1:length(elements)
        push!(result, pop!(nums))
    end
    return nums
end
using Test

@testset begin

candidate = f;
	@test(candidate([7, 1, 2, 6, 0, 2], [9, 0, 3]) == [7, 1, 2])
end
