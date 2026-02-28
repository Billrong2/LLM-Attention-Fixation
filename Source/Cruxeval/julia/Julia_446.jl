function f(array::Vector{Int64})::Vector{Int64} 
    l = length(array)
    if l % 2 == 0
        empty!(array)
    else
        reverse!(array)
    end
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([])) == Vector{Int64}([]))
end
