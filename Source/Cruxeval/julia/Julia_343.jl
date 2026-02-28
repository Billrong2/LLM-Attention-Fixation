function f(array::Vector{Any}, elem::Vector{Any})::Vector{Any} 
    append!(array, elem)
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([[1, 2, 3], [1, 2], 1], [[1, 2, 3], 3, [2, 1]]) == [[1, 2, 3], [1, 2], 1, [1, 2, 3], 3, [2, 1]])
end
