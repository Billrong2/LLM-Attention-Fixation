function f(n::Int64, array::Vector{Int64})::Vector{Vector{Int64}} 
    final = [copy(array)]
    for i in 1:n
        arr = copy(array)
        push!(arr, final[end]...)
        push!(final, arr)
    end
    return final
end
using Test

@testset begin

candidate = f;
	@test(candidate(1, [1, 2, 3]) == [[1, 2, 3], [1, 2, 3, 1, 2, 3]])
end
