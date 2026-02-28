function f(array::Vector{Int64}, elem::Int64)::Vector{Int64} 
    for idx in eachindex(array)
        if idx != 1 && array[idx] > elem && array[idx - 1] < elem
            insert!(array, idx, elem)
        end
    end
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3, 5, 8], 6) == [1, 2, 3, 5, 6, 8])
end
