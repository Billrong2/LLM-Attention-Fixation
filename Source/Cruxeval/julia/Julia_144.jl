function f(vectors::Vector{Vector{Int64}})::Vector{Vector{Int64}} 
    sorted_vecs = []
    for vec in vectors
        sort!(vec)
        push!(sorted_vecs, vec)
    end
    return sorted_vecs
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{Vector{Int64}}([])) == Vector{Vector{Int64}}([]))
end
