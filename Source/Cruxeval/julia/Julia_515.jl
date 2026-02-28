function f(array::Vector{Int64})::Vector{Int64} 
    result = copy(array)
    reverse!(result)
    result .= [item * 2 for item in result]
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3, 4, 5]) == [10, 8, 6, 4, 2])
end
