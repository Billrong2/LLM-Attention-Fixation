function f(array::Vector{Int64})::Vector{Int64} 
    i = 1
    while i <= length(array)
        if array[i] < 0
            splice!(array, i)
        else
            i += 1
        end
    end
    return array
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Int64}([])) == Vector{Int64}([]))
end
