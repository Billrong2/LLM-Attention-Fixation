function f(array::Vector{Int64}, index::Int64)::Int64 
    if index < 0
        index = length(array) + index
    end
    return array[index+1]
end
using Test

@testset begin

candidate = f;
	@test(candidate([1], 0) == 1)
end
