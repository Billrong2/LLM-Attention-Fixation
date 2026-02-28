function f(array::Vector{Int64}, elem::Int64)::Int64 
    elem = string(elem)
    d = 0
    for i in array
        if string(i) == elem
            d += 1
        end
    end
    return d
end
using Test

@testset begin

candidate = f;
	@test(candidate([-1, 2, 1, -8, -8, 2], 2) == 2)
end
