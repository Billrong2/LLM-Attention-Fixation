function f(array::Vector{Int64}, x::Int64, i::Int64)::Union{String, Vector{Int64}}
    if i < -length(array) || i > length(array) - 1
        return "no"
    end
    temp = array[i+1]
    array[i+1] = x
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 11, 4) == [1, 2, 3, 4, 11, 6, 7, 8, 9, 10])
end
