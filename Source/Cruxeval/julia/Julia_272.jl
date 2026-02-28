function f(base_list::Vector{Int64}, nums::Vector{Int64})::Vector{Int64} 
    append!(base_list, nums)
    res = copy(base_list)
    for i in 1:length(nums)
        push!(res, res[end - length(nums) + i])
    end
    return res
end
using Test

@testset begin

candidate = f;
	@test(candidate([9, 7, 5, 3, 1], [2, 4, 6, 8, 0]) == [9, 7, 5, 3, 1, 2, 4, 6, 8, 0, 2, 6, 0, 6, 6])
end
