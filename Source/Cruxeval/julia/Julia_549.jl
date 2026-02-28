function f(matrix::Vector{Vector{Int64}})::Vector{Vector{Int64}} 
    reverse!(matrix)
    result = Vector{Vector{Int64}}()
    for primary in matrix
        sort!(primary, rev=true)
        push!(result, primary)
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate([[1, 1, 1, 1]]) == [[1, 1, 1, 1]])
end
