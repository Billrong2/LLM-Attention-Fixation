function f(array::Vector{Int64})::Vector{Int64} 
    new_array = copy(array)
    new_array = reverse(new_array)
    return [x*x for x in new_array]
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 1]) == [1, 4, 1])
end
