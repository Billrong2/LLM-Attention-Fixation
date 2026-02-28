function f(array::Vector{Int64})::Vector{String} 
    reverse!(array)
    empty!(array)
    append!(array, fill("x", length(array)))
    reverse!(array)
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([3, -2, 0]) == Vector{String}([]))
end
