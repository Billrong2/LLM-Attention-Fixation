function f(nums::Vector{Int64})::String 
    score = Dict(0 => "F", 1 => "E", 2 => "D", 3 => "C", 4 => "B", 5 => "A", 6 => "")
    result = []
    for i in 1:length(nums)
        push!(result, get(score, nums[i], ""))
    end
    return join(result)
end
using Test

@testset begin

candidate = f;
	@test(candidate([4, 5]) == "BA")
end
