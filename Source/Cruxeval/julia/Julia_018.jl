function f(array::Vector{Int64}, elem::Int64)::Vector{Int64} 
    k = 1
    l = copy(array)
    for i in l
        if i > elem
            insert!(array, k, elem)
            break
        end
        k += 1
    end
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([5, 4, 3, 2, 1, 0], 3) == [3, 5, 4, 3, 2, 1, 0])
end
