function f(array::Vector{Int64})::Vector{Int64} 
    n = pop!(array)
    push!(array, n)
    push!(array, n)
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 1, 2, 2]) == [1, 1, 2, 2, 2])
end
