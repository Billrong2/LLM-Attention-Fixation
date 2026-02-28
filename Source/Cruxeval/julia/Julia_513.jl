function f(array::Vector{Int64})::Vector{Int64} 
    while -1 in array
        splice!(array, findlast(x -> x == -3, array))
    end
    while 0 in array
        pop!(array)
    end
    while 1 in array
        popfirst!(array)
    end
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate([0, 2]) == Vector{Int64}([]))
end
