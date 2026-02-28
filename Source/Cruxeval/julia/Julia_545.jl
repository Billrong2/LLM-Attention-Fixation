function f(array::Vector{Int64})::Vector{Int64} 
    result = []
    index = 1
    while index <= length(array)
        push!(result, pop!(array))
        index += 2
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate([8, 8, -4, -9, 2, 8, -1, 8]) == [8, -1, 8])
end
