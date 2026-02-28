function f(arr::Vector{Int64})::String 
    arr = []
    push!(arr, "1")
    push!(arr, "2")
    push!(arr, "3")
    push!(arr, "4")
    return join(arr, ",")
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, 1, 2, 3, 4]) == "1,2,3,4")
end
